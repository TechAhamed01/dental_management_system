import 'dart:convert';
import 'dart:typed_data';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/password_utils.dart';
import '../utils/jwt_utils.dart';
import '../utils/auth_utils.dart';
import '../services/document_storage_service.dart';

class ReceptionistEndpoint extends Endpoint {
  Future<AuthResponse> receptionistLogin(
    Session session,
    String email,
    String password,
  ) async {
    final receptionist = await Receptionist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
      include: Receptionist.include(
        hospital: Hospital.include(),
      ),
    );

    if (receptionist == null || !PasswordUtils.verifyPassword(password, receptionist.passwordHash)) {
      throw Exception('Invalid email or password.');
    }

    if (!receptionist.isActive) {
      throw Exception('Your account is deactivated.');
    }

    final token = JwtUtils.generateAccessToken(receptionist.id!, 'receptionist', hospitalId: receptionist.hospitalId);
    final refreshToken = JwtUtils.generateRefreshToken(receptionist.id!, 'receptionist', hospitalId: receptionist.hospitalId);

    await session.caches.global.put(
      'refresh_receptionist_${receptionist.id}',
      refreshToken,
      lifetime: const Duration(days: 7),
    );

    return AuthResponse(
      token: token,
      refreshToken: refreshToken,
      receptionist: receptionist,
    );
  }

  Future<void> receptionistLogout(Session session, int receptionistId) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    if (authUser.userId != receptionistId) {
      throw Exception('Forbidden. Cannot logout another user.');
    }
    await session.caches.global.invalidateKey('refresh_receptionist_$receptionistId');
  }

  // Used for backend setup. Do not use for public registration.
  Future<Receptionist> createReceptionist(
    Session session,
    int hospitalId,
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    AuthUtils.requireRole(session, ['admin']);
    final existing = await Receptionist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) {
      throw Exception('Receptionist with this email already exists.');
    }

    final passwordHash = PasswordUtils.hashPassword(password);

    final receptionist = Receptionist(
      hospitalId: hospitalId,
      fullName: fullName,
      email: email,
      phone: phone,
      passwordHash: passwordHash,
      isActive: true,
      createdAt: DateTime.now(),
    );

    return await Receptionist.db.insertRow(session, receptionist);
  }

  Future<Dentist?> receptionistRegisterDentist(
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
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    final hospitalId = authUser.hospitalId;

    if (hospitalId == null) {
      throw Exception('Forbidden. No hospital associated with this receptionist.');
    }

    if (!isTermsAccepted) {
      throw Exception('Terms must be accepted.');
    }

    final existingDentist = await Dentist.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingDentist != null) {
      throw Exception('A dentist with this email already exists.');
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

    Future<Map<String, dynamic>?> processDoc(String? url, String docType) async {
      if (url != null && url.startsWith('data:')) {
        final commaIdx = url.indexOf(',');
        if (commaIdx != -1) {
          final metaStr = url.substring(5, commaIdx);
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
        profilePhotoUrl: profilePhotoUrl,
        registrationFileUrl: registrationFileUrl,
        degreeFileUrl: degreeFileUrl,
        idFileUrl: idFileUrl,
        isTermsAccepted: isTermsAccepted,
        status: DentistStatus.pending,
        hospitalId: hospitalId, // Extracted securely from receptionist session
      );

      dentist = await Dentist.db.insertRow(session, dentist, transaction: transaction);
      
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
        for (final key in uploadedKeys) {
          await DocumentStorageService.deleteDocument(key);
        }
        throw Exception('Failed to upload registration documents: $e');
      }

      return dentist;
    });
  }

  Future<List<Dentist>> getDentistsForHospital(Session session) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    final hospitalId = authUser.hospitalId;

    if (hospitalId == null) {
      throw Exception('Forbidden. No hospital associated with this receptionist.');
    }

    return await Dentist.db.find(
      session,
      where: (t) => t.hospitalId.equals(hospitalId),
    );
  }
}
