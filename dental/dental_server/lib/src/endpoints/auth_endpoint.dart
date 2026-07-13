import 'package:serverpod/serverpod.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<Patient?> patientRegister(
    Session session,
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    final existingPatient = await Patient.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingPatient != null) {
      throw Exception('Patient with this email already exists.');
    }

    final passwordHash = _hashPassword(password);
    final patient = Patient(
      fullName: fullName,
      email: email,
      phone: phone,
      passwordHash: passwordHash,
    );

    return await Patient.db.insertRow(session, patient);
  }

  Future<Patient?> patientLogin(
    Session session,
    String email,
    String password,
  ) async {
    final passwordHash = _hashPassword(password);
    final patient = await Patient.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email) & t.passwordHash.equals(passwordHash),
    );

    if (patient == null) {
      throw Exception('Invalid email or password.');
    }

    return patient;
  }

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

    final passwordHash = _hashPassword(password);
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
    final passwordHash = _hashPassword(password);
    final dentist = await Dentist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email) & t.passwordHash.equals(passwordHash),
    );

    if (dentist == null) {
      throw Exception('Invalid email or password.');
    }

    if (dentist.status == DentistStatus.pending) {
      throw Exception('Your account is under review.');
    } else if (dentist.status == DentistStatus.rejected) {
      throw Exception('Your application has been rejected.');
    }

    return dentist;
  }

  Future<Admin?> adminLogin(
    Session session,
    String email,
    String password,
  ) async {
    final passwordHash = _hashPassword(password);
    final admin = await Admin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email) & t.passwordHash.equals(passwordHash),
    );

    if (admin == null) {
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
}
