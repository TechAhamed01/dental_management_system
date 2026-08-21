import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/password_utils.dart';
import '../utils/jwt_utils.dart';
import '../utils/auth_utils.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../services/document_storage_service.dart';
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
    
    // We will extract base64 data and replace with a marker
    Future<Map<String, dynamic>?> processDoc(String? url, String docType) async {
      if (url != null && url.startsWith('data:')) {
        // e.g. data:image/png;base64,iVBORw0KGgo...
        final commaIdx = url.indexOf(',');
        if (commaIdx != -1) {
          final metaStr = url.substring(5, commaIdx); // e.g. image/png;base64
          final base64Str = url.substring(commaIdx + 1);
          
          final isBase64 = metaStr.contains('base64');
          final mimeType = metaStr.split(';').first;
          
          if (isBase64) {
            final bytes = base64Decode(base64Str);
            final ext = mimeType.split('/').last;
            final fileName = '$docType.$ext';
            
            return {
              'mimeType': mimeType,
              'fileName': fileName,
              'bytes': bytes.buffer.asByteData(),
              'size': bytes.length,
            };
          }
        }
      }
      return null;
    }

    return await session.db.transaction((transaction) async {
      final docsToUpload = <String, Map<String, dynamic>>{};
      
      final profileMap = await processDoc(profilePhotoUrl, 'profile_photo');
      if (profileMap != null) docsToUpload['profile_photo'] = profileMap;
      
      final regMap = await processDoc(registrationFileUrl, 'registration');
      if (regMap != null) docsToUpload['registration'] = regMap;
      
      final degreeMap = await processDoc(degreeFileUrl, 'degree');
      if (degreeMap != null) docsToUpload['degree'] = degreeMap;
      
      final idMap = await processDoc(idFileUrl, 'identification');
      if (idMap != null) docsToUpload['identification'] = idMap;
      
      var dentist = Dentist(
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
        profilePhotoUrl: profilePhotoUrl, // We will overwrite below if uploaded
        registrationFileUrl: registrationFileUrl,
        degreeFileUrl: degreeFileUrl,
        idFileUrl: idFileUrl,
        isTermsAccepted: isTermsAccepted,
        status: DentistStatus.pending,
      );

      dentist = await Dentist.db.insertRow(session, dentist, transaction: transaction);
      
      // Now upload documents and create DentistDocument rows
      final List<String> uploadedKeys = [];
      bool needsUpdate = false;
      
      try {
        for (final entry in docsToUpload.entries) {
          final docType = entry.key;
          final map = entry.value;
          
          final storageKey = await DocumentStorageService.uploadDocument(
            dentistId: dentist.id!,
            documentType: docType,
            bytes: map['bytes'],
          );
          uploadedKeys.add(storageKey);
          
          var doc = DentistDocument(
            dentistId: dentist.id!,
            documentType: docType,
            fileName: map['fileName'],
            mimeType: map['mimeType'],
            storageKey: storageKey,
            fileSize: map['size'],
            uploadedAt: DateTime.now(),
          );
          
          doc = await DentistDocument.db.insertRow(session, doc, transaction: transaction);
          
          // Update the dentist record with the marker
          if (docType == 'profile_photo') dentist.profilePhotoUrl = '[SECURE_DOCUMENT:${doc.id}]';
          if (docType == 'registration') dentist.registrationFileUrl = '[SECURE_DOCUMENT:${doc.id}]';
          if (docType == 'degree') dentist.degreeFileUrl = '[SECURE_DOCUMENT:${doc.id}]';
          if (docType == 'identification') dentist.idFileUrl = '[SECURE_DOCUMENT:${doc.id}]';
          needsUpdate = true;
        }
        
        if (needsUpdate) {
          await Dentist.db.updateRow(session, dentist, transaction: transaction);
        }
      } catch (e) {
        // If anything fails during upload/DB insertion, clean up files manually 
        // since the DB transaction will rollback, but files won't.
        for (final key in uploadedKeys) {
          await DocumentStorageService.deleteDocument(key);
        }
        throw Exception('Failed to upload registration documents: $e');
      }

      return dentist;
    });
  }

  Future<AuthResponse> dentistLogin(
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

    if (dentist.status == DentistStatus.pending || dentist.status == DentistStatus.rejected) {
      throw Exception('Your account is not approved yet.');
    }

    final token = JwtUtils.generateAccessToken(dentist.id!, 'dentist');
    final refreshToken = JwtUtils.generateRefreshToken(dentist.id!, 'dentist');

    await session.caches.global.put(
      'refresh_dentist_${dentist.id}',
      refreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: token,
      refreshToken: refreshToken,
      dentist: dentist,
    );
  }

  Future<void> dentistLogout(Session session, int dentistId) async {
    final authUser = AuthUtils.requireRole(session, ['dentist']);
    if (authUser.userId != dentistId) {
      throw Exception('Forbidden. Cannot logout another user.');
    }
    await session.caches.global.invalidateKey('refresh_dentist_$dentistId');
  }

  Future<AuthResponse> adminLogin(
    Session session,
    String email,
    String password,
  ) async {
    final admin = await Admin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    print('ADMIN LOGIN ATTEMPT: email=$email, admin_found=${admin != null}');
    if (admin != null) {
      print('ADMIN HASH: ${admin.passwordHash}, MATCH: ${PasswordUtils.verifyPassword(password, admin.passwordHash)}');
    }

    if (admin == null || !PasswordUtils.verifyPassword(password, admin.passwordHash)) {
      throw Exception('Invalid admin email or password.');
    }

    final token = JwtUtils.generateAccessToken(admin.id!, 'admin');
    final refreshToken = JwtUtils.generateRefreshToken(admin.id!, 'admin');

    await session.caches.global.put(
      'refresh_admin_${admin.id}',
      refreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: token,
      refreshToken: refreshToken,
      admin: admin,
    );
  }

  Future<void> adminLogout(Session session, int adminId) async {
    final authUser = AuthUtils.requireRole(session, ['admin']);
    if (authUser.userId != adminId) {
      throw Exception('Forbidden.');
    }
    await session.caches.global.invalidateKey('refresh_admin_$adminId');
  }

  Future<AuthResponse> refreshAuthToken(Session session, String refreshToken) async {
    final jwt = JwtUtils.verifyRefreshToken(refreshToken);
    if (jwt == null) {
      throw Exception('Invalid or expired refresh token.');
    }

    final userId = jwt.payload['userId'] as int;
    final role = jwt.payload['role'] as String;
    final hospitalId = jwt.payload['hospitalId'] as int?;

    final storedToken = await session.caches.global.get<String>('refresh_${role}_$userId');
    if (storedToken == null || storedToken != refreshToken) {
      throw Exception('Refresh token revoked or not found.');
    }

    if (role == 'admin') {
      final admin = await Admin.db.findById(session, userId);
      if (admin == null) throw Exception('Admin not found.');
      final newToken = JwtUtils.generateAccessToken(userId, role);
      final newRefreshToken = JwtUtils.generateRefreshToken(userId, role);
      await session.caches.global.put('refresh_${role}_$userId', newRefreshToken, lifetime: const Duration(days: 7));
      return AuthResponse(token: newToken, refreshToken: newRefreshToken, admin: admin);
    } else if (role == 'dentist') {
      final dentist = await Dentist.db.findById(session, userId);
      if (dentist == null) throw Exception('Dentist not found.');
      if (dentist.status != DentistStatus.approved) throw Exception('Dentist account is not approved.');
      final newToken = JwtUtils.generateAccessToken(userId, role);
      final newRefreshToken = JwtUtils.generateRefreshToken(userId, role);
      await session.caches.global.put('refresh_${role}_$userId', newRefreshToken, lifetime: const Duration(days: 7));
      return AuthResponse(token: newToken, refreshToken: newRefreshToken, dentist: dentist);
    } else if (role == 'receptionist') {
      final receptionist = await Receptionist.db.findById(session, userId);
      if (receptionist == null || !receptionist.isActive) throw Exception('Receptionist not found or inactive.');
      final newToken = JwtUtils.generateAccessToken(userId, role, hospitalId: hospitalId);
      final newRefreshToken = JwtUtils.generateRefreshToken(userId, role, hospitalId: hospitalId);
      await session.caches.global.put('refresh_${role}_$userId', newRefreshToken, lifetime: const Duration(days: 7));
      return AuthResponse(token: newToken, refreshToken: newRefreshToken, receptionist: receptionist);
    } else {
      throw Exception('Role $role cannot use this generic refresh endpoint. Use patientRefreshToken.');
    }
  }

  Future<List<Dentist>> getPendingDentists(Session session) async {
    AuthUtils.requireRole(session, ['admin']);
    return await Dentist.db.find(
      session,
      where: (t) => t.status.equals(DentistStatus.pending),
      include: Dentist.include(hospital: Hospital.include()),
    );
  }

  Future<Dentist> approveDentist(Session session, int dentistId, {String adminEmail = 'Admin'}) async {
    AuthUtils.requireRole(session, ['admin']);
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
    AuthUtils.requireRole(session, ['admin']);
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
    AuthUtils.requireRole(session, ['admin']);
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
    AuthUtils.requireRole(session, ['admin']);
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
    AuthUtils.requireRole(session, ['admin']);
    final logs = await AuditLog.db.find(
      session,
      where: (t) => t.dentistId.equals(dentistId),
    );
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs;
  }

  Future<void> logPdfDownload(Session session, int dentistId, {String adminEmail = 'Admin'}) async {
    AuthUtils.requireRole(session, ['admin']);
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
    AuthUtils.requireRole(session, ['admin']);
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
    return await Dentist.db.find(
      session,
      include: Dentist.include(hospital: Hospital.include()),
    );
  }

  Future<List<Dentist>> getApprovedDentists(Session session) async {
    return await Dentist.db.find(
      session, 
      where: (t) => t.status.equals(DentistStatus.approved),
      include: Dentist.include(hospital: Hospital.include()),
    );
  }

  Future<List<Dentist>> getRejectedDentists(Session session) async {
    return await Dentist.db.find(
      session, 
      where: (t) => t.status.equals(DentistStatus.rejected),
      include: Dentist.include(hospital: Hospital.include()),
    );
  }

  Future<List<Dentist>> getSuspendedDentists(Session session) async {
    return await Dentist.db.find(
      session, 
      where: (t) => t.status.equals(DentistStatus.suspended),
      include: Dentist.include(hospital: Hospital.include()),
    );
  }

  Future<List<Dentist>> getTerminatedDentists(Session session) async {
    return await Dentist.db.find(
      session, 
      where: (t) => t.status.equals(DentistStatus.terminated),
      include: Dentist.include(hospital: Hospital.include()),
    );
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
