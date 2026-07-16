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

  // DENTIST AUTHENTICATION (Placeholder using legacy style for now, to be updated in iteration 2)
  Future<Dentist?> dentistRegister(
    Session session,
    String fullName,
    String email,
    String phone,
    String password,
    String licenseNumber,
    String specialization,
    int experience,
    String clinicName,
    String clinicAddress,
    String? profilePhotoUrl,
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

    final passwordHash = PasswordUtils.hashPassword(password);
    final dentist = Dentist(
      fullName: fullName,
      email: email,
      phone: phone,
      passwordHash: passwordHash,
      licenseNumber: licenseNumber,
      specialization: specialization,
      experience: experience,
      clinicName: clinicName,
      clinicAddress: clinicAddress,
      profilePhotoUrl: profilePhotoUrl,
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

  Future<Dentist> approveDentist(Session session, int dentistId) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }

    dentist.status = DentistStatus.approved;
    return await Dentist.db.updateRow(session, dentist);
  }

  Future<Dentist> rejectDentist(Session session, int dentistId) async {
    final dentist = await Dentist.db.findById(session, dentistId);
    if (dentist == null) {
      throw Exception('Dentist not found.');
    }

    dentist.status = DentistStatus.rejected;
    return await Dentist.db.updateRow(session, dentist);
  }
  Future<DashboardStats> getDashboardStats(Session session) async {
    final totalPatients = await Patient.db.count(session);
    final totalDoctors = await Dentist.db.count(session);
    final pendingDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.pending));
    final approvedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.approved));
    final rejectedDoctors = await Dentist.db.count(session, where: (t) => t.status.equals(DentistStatus.rejected));

    return DashboardStats(
      totalPatients: totalPatients,
      totalDoctors: totalDoctors,
      pendingDoctors: pendingDoctors,
      approvedDoctors: approvedDoctors,
      rejectedDoctors: rejectedDoctors,
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
}
