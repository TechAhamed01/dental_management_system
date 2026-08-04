import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/password_utils.dart';
import '../utils/jwt_utils.dart';

class AuthEndpoint extends Endpoint {

  // PATIENT AUTHENTICATION

  Future<AuthResponse> patientRegister(
    Session session,
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    // 1. Validation
    if (fullName.isEmpty || email.isEmpty || phone.isEmpty || password.length < 8) {
      throw Exception('Invalid input data. Password must be at least 8 characters.');
    }

    final existingPatient = await Patient.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingPatient != null) {
      throw Exception('Patient with this email already exists.');
    }

    // 2. Hash Password
    final passwordHash = PasswordUtils.hashPassword(password);
    var patient = Patient(
      fullName: fullName,
      email: email,
      phone: phone,
      passwordHash: passwordHash,
    );

    patient = await Patient.db.insertRow(session, patient);

    // 3. Generate Tokens
    final token = JwtUtils.generateAccessToken(patient.id!, 'patient');
    final refreshToken = JwtUtils.generateRefreshToken(patient.id!, 'patient');

    // 4. Store Refresh Token in Redis
    await session.caches.global.put(
      'refresh_patient_${patient.id}',
      refreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: token,
      refreshToken: refreshToken,
      patient: patient,
    );
  }

  Future<AuthResponse> patientLogin(
    Session session,
    String email,
    String password,
  ) async {
    final patient = await Patient.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (patient == null || !PasswordUtils.verifyPassword(password, patient.passwordHash)) {
      throw Exception('Invalid email or password.');
    }

    final token = JwtUtils.generateAccessToken(patient.id!, 'patient');
    final refreshToken = JwtUtils.generateRefreshToken(patient.id!, 'patient');

    await session.caches.global.put(
      'refresh_patient_${patient.id}',
      refreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: token,
      refreshToken: refreshToken,
      patient: patient,
    );
  }

  Future<void> patientLogout(Session session, int patientId) async {
    await session.caches.global.invalidateKey('refresh_patient_$patientId');
  }

  Future<AuthResponse> patientRefreshToken(Session session, String refreshToken) async {
    final jwt = JwtUtils.verifyRefreshToken(refreshToken);
    if (jwt == null) {
      throw Exception('Invalid or expired refresh token.');
    }

    final userId = jwt.payload['userId'] as int;
    final role = jwt.payload['role'] as String;

    if (role != 'patient') {
      throw Exception('Invalid role for this token.');
    }

    final storedToken = await session.caches.global.get<String>('refresh_patient_$userId');
    if (storedToken == null || storedToken != refreshToken) {
      throw Exception('Refresh token revoked or not found.');
    }

    final patient = await Patient.db.findById(session, userId);
    if (patient == null) {
      throw Exception('Patient not found.');
    }

    final newToken = JwtUtils.generateAccessToken(userId, 'patient');
    final newRefreshToken = JwtUtils.generateRefreshToken(userId, 'patient');

    await session.caches.global.put(
      'refresh_patient_$userId',
      newRefreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: newToken,
      refreshToken: newRefreshToken,
      patient: patient,
    );
  }

  // DENTIST AUTHENTICATION
  Future<Dentist?> dentistRegister(
    Session session,
    String fullName,
    String email,
    String phone,
    String password,
    String? dateOfBirth,
    String licenseNumber,
    String specialization,
    String? qualification,
    int experience,
    String clinicName,
    String clinicAddress,
    String? profilePhotoUrl,
    String? registrationFileUrl,
    String? degreeFileUrl,
    String? idFileUrl,
    bool isTermsAccepted,
  ) async {
    if (!isTermsAccepted) {
      throw Exception('Terms must be accepted.');
    }

    final existingDentist = await Dentist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingDentist != null) {
      throw Exception('Dentist with this email already exists.');
    }

    final allExistingDentists = await Dentist.db.find(session);
    int maxCodeNum = 0;
    for (final d in allExistingDentists) {
      if (d.dentistCode != null && d.dentistCode!.startsWith('D')) {
        final numPart = int.tryParse(d.dentistCode!.substring(1));
        if (numPart != null && numPart > maxCodeNum) {
          maxCodeNum = numPart;
        }
      }
    }
    final nextCodeNum = maxCodeNum + 1;
    final dentistCode = 'D${nextCodeNum.toString().padLeft(4, '0')}';

    final passwordHash = PasswordUtils.hashPassword(password);
    final dentist = Dentist(
      dentistCode: dentistCode,
      fullName: fullName,
      email: email,
      phone: phone,
      passwordHash: passwordHash,
      dateOfBirth: dateOfBirth,
      licenseNumber: licenseNumber,
      specialization: specialization,
      qualification: qualification,
      experience: experience,
      clinicName: clinicName,
      clinicAddress: clinicAddress,
      profilePhotoUrl: profilePhotoUrl,
      registrationFileUrl: registrationFileUrl,
      degreeFileUrl: degreeFileUrl,
      idFileUrl: idFileUrl,
      isTermsAccepted: isTermsAccepted,
      status: DentistStatus.pending,
    );

    return await Dentist.db.insertRow(session, dentist);
  }

  Future<Dentist?> dentistLogin(
    Session session,
    String email,
    String password,
  ) async {
    final dentist = await Dentist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (dentist == null || !PasswordUtils.verifyPassword(password, dentist.passwordHash)) {
      throw Exception('Invalid email or password.');
    }

    if (dentist.status == DentistStatus.terminated) {
      throw Exception('Your account has been permanently terminated. Please contact administration.');
    }

    if (dentist.status == DentistStatus.suspended) {
      final now = DateTime.now();
      if (dentist.suspensionEndsAt != null && now.isBefore(dentist.suspensionEndsAt!)) {
        final dateStr = '${dentist.suspensionEndsAt!.year}-${dentist.suspensionEndsAt!.month.toString().padLeft(2, '0')}-${dentist.suspensionEndsAt!.day.toString().padLeft(2, '0')}';
        final reasonPart = dentist.suspensionReason != null && dentist.suspensionReason!.isNotEmpty
            ? ' Reason: ${dentist.suspensionReason}'
            : '';
        throw Exception('Account suspended until $dateStr.$reasonPart');
      } else {
        dentist.status = DentistStatus.approved;
        dentist.suspendedAt = null;
        dentist.suspensionEndsAt = null;
        dentist.suspensionReason = null;
        dentist.suspendedBy = null;
        await Dentist.db.updateRow(session, dentist);

        try {
          await _recordAuditLog(
            session,
            dentist.id!,
            'System',
            'Automatically Reactivated',
            'Suspension period expired',
          );
        } catch (e) {
          session.log('Failed to record auto reactivation audit log: $e');
        }
      }
    }

    return dentist;
  }

  // ADMIN AUTHENTICATION
  Future<Admin?> adminLogin(
    Session session,
    String email,
    String password,
  ) async {
    final admin = await Admin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (admin == null || !PasswordUtils.verifyPassword(password, admin.passwordHash)) {
      throw Exception('Invalid admin email or password.');
    }

    return admin;
  }

  Future<List<Dentist>> getPendingDentists(Session session) async {
    return await Dentist.db.find(
      session,
      where: (t) => t.status.equals(DentistStatus.pending),
    );
  }

  Future<Dentist> approveDentist(Session session, int dentistId, {String adminEmail = 'Admin'}) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }
    if (dentist.status == DentistStatus.terminated) {
      throw Exception('Already terminated. Cannot approve a terminated dentist.');
    }

    dentist.status = DentistStatus.approved;
    final updated = await Dentist.db.updateRow(session, dentist);

    try {
      await _recordAuditLog(session, dentistId, adminEmail, 'Approved', 'Application approved by admin');
    } catch (e) {
      session.log('Audit log error: $e');
    }
    return updated;
  }

  Future<Dentist> rejectDentist(Session session, int dentistId, {String adminEmail = 'Admin', String? reason}) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }
    if (dentist.status == DentistStatus.terminated) {
      throw Exception('Already terminated. Cannot reject a terminated dentist.');
    }

    dentist.status = DentistStatus.rejected;
    final updated = await Dentist.db.updateRow(session, dentist);

    try {
      await _recordAuditLog(session, dentistId, adminEmail, 'Rejected', reason ?? 'Application rejected by admin');
    } catch (e) {
      session.log('Audit log error: $e');
    }
    return updated;
  }

  Future<Dentist> suspendDentist(
    Session session,
    int dentistId,
    DateTime endsAt,
    String reason, {
    String adminEmail = 'Admin',
  }) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }
    if (dentist.status == DentistStatus.terminated) {
      throw Exception('Already terminated. Cannot suspend a terminated account.');
    }
    if (dentist.status == DentistStatus.suspended) {
      throw Exception('Already suspended.');
    }
    if (!endsAt.isAfter(DateTime.now())) {
      throw Exception('Invalid suspension period. End date must be in the future.');
    }

    dentist.status = DentistStatus.suspended;
    dentist.suspendedAt = DateTime.now();
    dentist.suspensionEndsAt = endsAt;
    dentist.suspensionReason = reason;
    dentist.suspendedBy = adminEmail;

    final updated = await Dentist.db.updateRow(session, dentist);

    try {
      await _recordAuditLog(session, dentistId, adminEmail, 'Suspended', reason);
    } catch (e) {
      session.log('Audit log error: $e');
    }
    return updated;
  }

  Future<Dentist> terminateDentist(
    Session session,
    int dentistId,
    String reason, {
    String adminEmail = 'Admin',
  }) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }
    if (dentist.status == DentistStatus.terminated) {
      throw Exception('Already terminated.');
    }

    dentist.status = DentistStatus.terminated;
    dentist.terminatedAt = DateTime.now();
    dentist.terminationReason = reason;
    dentist.terminatedBy = adminEmail;
    dentist.suspendedAt = null;
    dentist.suspensionEndsAt = null;
    dentist.suspensionReason = null;
    dentist.suspendedBy = null;

    final updated = await Dentist.db.updateRow(session, dentist);

    try {
      await _recordAuditLog(session, dentistId, adminEmail, 'Terminated', reason);
    } catch (e) {
      session.log('Audit log error: $e');
    }
    return updated;
  }

  Future<List<AuditLog>> getDentistAuditLogs(Session session, int dentistId) async {
    final logs = await AuditLog.db.find(
      session,
      where: (t) => t.dentistId.equals(dentistId),
    );
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs;
  }

  Future<void> logPdfDownload(Session session, int dentistId, {String adminEmail = 'Admin'}) async {
    try {
      await _recordAuditLog(session, dentistId, adminEmail, 'Downloaded PDF', 'Admin downloaded dentist profile & application report');
    } catch (e) {
      session.log('Audit log error for PDF download: $e');
    }
  }

  Future<Dentist?> searchDentistByCode(Session session, String code) async {
    return await Dentist.db.findFirstRow(
      session,
      where: (t) => t.dentistCode.equals(code.trim().toUpperCase()),
    );
  }

  Future<DashboardStats> getDashboardStats(Session session) async {
    final totalPatients = await Patient.db.count(session);
    final totalDoctors = await Dentist.db.count(session);
    final pendingDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.pending));
    final approvedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.approved));
    final rejectedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.rejected));
    final suspendedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.suspended));
    final terminatedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.terminated));

    return DashboardStats(
      totalPatients: totalPatients,
      totalDoctors: totalDoctors,
      pendingDoctors: pendingDoctors,
      approvedDoctors: approvedDoctors,
      rejectedDoctors: rejectedDoctors,
      suspendedDoctors: suspendedDoctors,
      terminatedDoctors: terminatedDoctors,
    );
  }

  Future<List<Patient>> getAllPatients(Session session) async {
    return await Patient.db.find(session);
  }

  Future<List<Dentist>> getAllDentists(Session session) async {
    return await Dentist.db.find(session);
  }

  Future<List<Dentist>> getApprovedDentists(Session session) async {
    return await Dentist.db.find(session, where: (t) => t.status.equals(DentistStatus.approved));
  }

  Future<List<Dentist>> getRejectedDentists(Session session) async {
    return await Dentist.db.find(session, where: (t) => t.status.equals(DentistStatus.rejected));
  }

  Future<List<Dentist>> getSuspendedDentists(Session session) async {
    return await Dentist.db.find(session, where: (t) => t.status.equals(DentistStatus.suspended));
  }

  Future<List<Dentist>> getTerminatedDentists(Session session) async {
    return await Dentist.db.find(session, where: (t) => t.status.equals(DentistStatus.terminated));
  }

  Future<void> _recordAuditLog(
    Session session,
    int dentistId,
    String adminEmail,
    String action,
    String? reason,
  ) async {
    final log = AuditLog(
      dentistId: dentistId,
      adminEmail: adminEmail,
      action: action,
      reason: reason,
      timestamp: DateTime.now(),
    );
    await AuditLog.db.insertRow(session, log);
  }
}
