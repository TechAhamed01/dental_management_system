/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:dental_client/src/protocol/appointment/appointment.dart' as _i5;
import 'package:dental_client/src/protocol/auth/dentist.dart' as _i6;
import 'package:dental_client/src/protocol/auth/auth_response.dart' as _i7;
import 'package:dental_client/src/protocol/auth/audit_log.dart' as _i8;
import 'package:dental_client/src/protocol/auth/dashboard_stats.dart' as _i9;
import 'package:dental_client/src/protocol/auth/patient.dart' as _i10;
import 'package:dental_client/src/protocol/appointment/dental_image.dart'
    as _i11;
import 'dart:typed_data' as _i12;
import 'package:dental_client/src/protocol/dentist_document/dentist_document.dart'
    as _i13;
import 'package:dental_client/src/protocol/hospital/hospital.dart' as _i14;
import 'package:dental_client/src/protocol/hospital/receptionist.dart' as _i15;
import 'package:dental_client/src/protocol/greetings/greeting.dart' as _i16;
import 'protocol.dart' as _i17;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointAppointment extends _i2.EndpointRef {
  EndpointAppointment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appointment';

  /// Creates a new appointment request from a Patient.
  _i3.Future<_i5.Appointment> createAppointment(
    int hospitalId,
    DateTime date,
    String startTime,
    String endTime,
    String reason,
  ) => caller.callServerEndpoint<_i5.Appointment>(
    'appointment',
    'createAppointment',
    {
      'hospitalId': hospitalId,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
    },
  );

  /// Gets appointments for the authenticated patient
  _i3.Future<List<_i5.Appointment>> getPatientAppointments() =>
      caller.callServerEndpoint<List<_i5.Appointment>>(
        'appointment',
        'getPatientAppointments',
        {},
      );

  /// Allows patient to cancel their pending appointment
  _i3.Future<_i5.Appointment> cancelPatientAppointment(int appointmentId) =>
      caller.callServerEndpoint<_i5.Appointment>(
        'appointment',
        'cancelPatientAppointment',
        {'appointmentId': appointmentId},
      );

  /// Gets appointments for the authenticated receptionist's hospital
  _i3.Future<List<_i5.Appointment>> getHospitalAppointments() =>
      caller.callServerEndpoint<List<_i5.Appointment>>(
        'appointment',
        'getHospitalAppointments',
        {},
      );

  /// Gets details of a specific hospital appointment
  _i3.Future<_i5.Appointment?> getHospitalAppointmentDetails(
    int appointmentId,
  ) => caller.callServerEndpoint<_i5.Appointment?>(
    'appointment',
    'getHospitalAppointmentDetails',
    {'appointmentId': appointmentId},
  );

  /// Gets available approved dentists for a specific appointment in the receptionist's hospital
  _i3.Future<List<_i6.Dentist>> getAvailableDentistsForAppointment() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'appointment',
        'getAvailableDentistsForAppointment',
        {},
      );

  /// Allocates an approved dentist to a pending appointment
  _i3.Future<_i5.Appointment> allocateDentist(
    int appointmentId,
    int dentistId,
  ) => caller.callServerEndpoint<_i5.Appointment>(
    'appointment',
    'allocateDentist',
    {
      'appointmentId': appointmentId,
      'dentistId': dentistId,
    },
  );

  /// Gets appointments allocated to the authenticated dentist
  _i3.Future<List<_i5.Appointment>> getDentistAppointments() =>
      caller.callServerEndpoint<List<_i5.Appointment>>(
        'appointment',
        'getDentistAppointments',
        {},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i2.EndpointRef {
  EndpointAuth(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i3.Future<_i7.AuthResponse> patientRegister(
    String fullName,
    String email,
    String phone,
    String password,
  ) => caller.callServerEndpoint<_i7.AuthResponse>(
    'auth',
    'patientRegister',
    {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    },
  );

  _i3.Future<_i7.AuthResponse> patientLogin(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i7.AuthResponse>(
    'auth',
    'patientLogin',
    {
      'email': email,
      'password': password,
    },
  );

  _i3.Future<void> patientLogout(int patientId) =>
      caller.callServerEndpoint<void>(
        'auth',
        'patientLogout',
        {'patientId': patientId},
      );

  _i3.Future<_i7.AuthResponse> patientRefreshToken(String refreshToken) =>
      caller.callServerEndpoint<_i7.AuthResponse>(
        'auth',
        'patientRefreshToken',
        {'refreshToken': refreshToken},
      );

  _i3.Future<_i6.Dentist?> dentistRegister(
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
  ) => caller.callServerEndpoint<_i6.Dentist?>(
    'auth',
    'dentistRegister',
    {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'qualification': qualification,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'profilePhotoUrl': profilePhotoUrl,
      'registrationFileUrl': registrationFileUrl,
      'degreeFileUrl': degreeFileUrl,
      'idFileUrl': idFileUrl,
      'isTermsAccepted': isTermsAccepted,
    },
  );

  _i3.Future<_i7.AuthResponse> dentistLogin(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i7.AuthResponse>(
    'auth',
    'dentistLogin',
    {
      'email': email,
      'password': password,
    },
  );

  _i3.Future<void> dentistLogout(int dentistId) =>
      caller.callServerEndpoint<void>(
        'auth',
        'dentistLogout',
        {'dentistId': dentistId},
      );

  _i3.Future<_i7.AuthResponse> adminLogin(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i7.AuthResponse>(
    'auth',
    'adminLogin',
    {
      'email': email,
      'password': password,
    },
  );

  _i3.Future<void> adminLogout(int adminId) => caller.callServerEndpoint<void>(
    'auth',
    'adminLogout',
    {'adminId': adminId},
  );

  _i3.Future<_i7.AuthResponse> refreshAuthToken(String refreshToken) =>
      caller.callServerEndpoint<_i7.AuthResponse>(
        'auth',
        'refreshAuthToken',
        {'refreshToken': refreshToken},
      );

  _i3.Future<List<_i6.Dentist>> getPendingDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getPendingDentists',
        {},
      );

  _i3.Future<_i6.Dentist> approveDentist(
    int dentistId, {
    required String adminEmail,
  }) => caller.callServerEndpoint<_i6.Dentist>(
    'auth',
    'approveDentist',
    {
      'dentistId': dentistId,
      'adminEmail': adminEmail,
    },
  );

  _i3.Future<_i6.Dentist> rejectDentist(
    int dentistId, {
    required String adminEmail,
    String? reason,
  }) => caller.callServerEndpoint<_i6.Dentist>(
    'auth',
    'rejectDentist',
    {
      'dentistId': dentistId,
      'adminEmail': adminEmail,
      'reason': reason,
    },
  );

  _i3.Future<_i6.Dentist> suspendDentist(
    int dentistId,
    DateTime endsAt,
    String reason, {
    required String adminEmail,
  }) => caller.callServerEndpoint<_i6.Dentist>(
    'auth',
    'suspendDentist',
    {
      'dentistId': dentistId,
      'endsAt': endsAt,
      'reason': reason,
      'adminEmail': adminEmail,
    },
  );

  _i3.Future<_i6.Dentist> terminateDentist(
    int dentistId,
    String reason, {
    required String adminEmail,
  }) => caller.callServerEndpoint<_i6.Dentist>(
    'auth',
    'terminateDentist',
    {
      'dentistId': dentistId,
      'reason': reason,
      'adminEmail': adminEmail,
    },
  );

  _i3.Future<List<_i8.AuditLog>> getDentistAuditLogs(int dentistId) =>
      caller.callServerEndpoint<List<_i8.AuditLog>>(
        'auth',
        'getDentistAuditLogs',
        {'dentistId': dentistId},
      );

  _i3.Future<void> logPdfDownload(
    int dentistId, {
    required String adminEmail,
  }) => caller.callServerEndpoint<void>(
    'auth',
    'logPdfDownload',
    {
      'dentistId': dentistId,
      'adminEmail': adminEmail,
    },
  );

  _i3.Future<_i6.Dentist?> searchDentistByCode(String code) =>
      caller.callServerEndpoint<_i6.Dentist?>(
        'auth',
        'searchDentistByCode',
        {'code': code},
      );

  _i3.Future<_i9.DashboardStats> getDashboardStats() =>
      caller.callServerEndpoint<_i9.DashboardStats>(
        'auth',
        'getDashboardStats',
        {},
      );

  _i3.Future<List<_i10.Patient>> getAllPatients() =>
      caller.callServerEndpoint<List<_i10.Patient>>(
        'auth',
        'getAllPatients',
        {},
      );

  _i3.Future<List<_i6.Dentist>> getAllDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getAllDentists',
        {},
      );

  _i3.Future<List<_i6.Dentist>> getApprovedDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getApprovedDentists',
        {},
      );

  _i3.Future<List<_i6.Dentist>> getRejectedDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getRejectedDentists',
        {},
      );

  _i3.Future<List<_i6.Dentist>> getSuspendedDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getSuspendedDentists',
        {},
      );

  _i3.Future<List<_i6.Dentist>> getTerminatedDentists() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'auth',
        'getTerminatedDentists',
        {},
      );
}

/// {@category Endpoint}
class EndpointDentalImage extends _i2.EndpointRef {
  EndpointDentalImage(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dentalImage';

  /// Uploads a dental image for an appointment
  _i3.Future<_i11.DentalImage> uploadDentalImage(
    int appointmentId,
    String fileName,
    String mimeType,
    _i12.ByteData imageData,
  ) => caller.callServerEndpoint<_i11.DentalImage>(
    'dentalImage',
    'uploadDentalImage',
    {
      'appointmentId': appointmentId,
      'fileName': fileName,
      'mimeType': mimeType,
      'imageData': imageData,
    },
  );

  /// Gets all dental images for a specific appointment
  _i3.Future<List<_i11.DentalImage>> getDentalImagesForAppointment(
    int appointmentId,
  ) => caller.callServerEndpoint<List<_i11.DentalImage>>(
    'dentalImage',
    'getDentalImagesForAppointment',
    {'appointmentId': appointmentId},
  );

  /// Downloads a dental image securely
  _i3.Future<_i12.ByteData> downloadDentalImage(int dentalImageId) =>
      caller.callServerEndpoint<_i12.ByteData>(
        'dentalImage',
        'downloadDentalImage',
        {'dentalImageId': dentalImageId},
      );
}

/// {@category Endpoint}
class EndpointDocument extends _i2.EndpointRef {
  EndpointDocument(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  /// Fetches the metadata of documents for a specific dentist.
  /// Enforces authorization:
  /// - Admin: All access
  /// - Dentist: Only their own
  /// - Receptionist: Only dentists in their hospital
  _i3.Future<List<_i13.DentistDocument>> getDentistDocuments(int dentistId) =>
      caller.callServerEndpoint<List<_i13.DentistDocument>>(
        'document',
        'getDentistDocuments',
        {'dentistId': dentistId},
      );

  /// Securely downloads a document's binary data given its metadata ID.
  _i3.Future<_i12.ByteData?> downloadDocument(int documentId) =>
      caller.callServerEndpoint<_i12.ByteData?>(
        'document',
        'downloadDocument',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointHospital extends _i2.EndpointRef {
  EndpointHospital(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hospital';

  _i3.Future<_i14.Hospital> createHospital(
    String name,
    String address,
    String phone,
    String email,
  ) => caller.callServerEndpoint<_i14.Hospital>(
    'hospital',
    'createHospital',
    {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    },
  );

  _i3.Future<_i14.Hospital?> getHospital(int id) =>
      caller.callServerEndpoint<_i14.Hospital?>(
        'hospital',
        'getHospital',
        {'id': id},
      );

  _i3.Future<List<_i14.Hospital>> listActiveHospitals() =>
      caller.callServerEndpoint<List<_i14.Hospital>>(
        'hospital',
        'listActiveHospitals',
        {},
      );

  _i3.Future<_i14.Hospital> updateHospital(_i14.Hospital hospital) =>
      caller.callServerEndpoint<_i14.Hospital>(
        'hospital',
        'updateHospital',
        {'hospital': hospital},
      );
}

/// {@category Endpoint}
class EndpointReceptionist extends _i2.EndpointRef {
  EndpointReceptionist(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'receptionist';

  _i3.Future<_i7.AuthResponse> receptionistLogin(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i7.AuthResponse>(
    'receptionist',
    'receptionistLogin',
    {
      'email': email,
      'password': password,
    },
  );

  _i3.Future<void> receptionistLogout(int receptionistId) =>
      caller.callServerEndpoint<void>(
        'receptionist',
        'receptionistLogout',
        {'receptionistId': receptionistId},
      );

  _i3.Future<_i15.Receptionist> createReceptionist(
    int hospitalId,
    String fullName,
    String email,
    String phone,
    String password,
  ) => caller.callServerEndpoint<_i15.Receptionist>(
    'receptionist',
    'createReceptionist',
    {
      'hospitalId': hospitalId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    },
  );

  _i3.Future<_i6.Dentist?> receptionistRegisterDentist(
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
  ) => caller.callServerEndpoint<_i6.Dentist?>(
    'receptionist',
    'receptionistRegisterDentist',
    {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'qualification': qualification,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'profilePhotoUrl': profilePhotoUrl,
      'registrationFileUrl': registrationFileUrl,
      'degreeFileUrl': degreeFileUrl,
      'idFileUrl': idFileUrl,
      'isTermsAccepted': isTermsAccepted,
    },
  );

  _i3.Future<List<_i6.Dentist>> getDentistsForHospital() =>
      caller.callServerEndpoint<List<_i6.Dentist>>(
        'receptionist',
        'getDentistsForHospital',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i16.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i16.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i17.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    appointment = EndpointAppointment(this);
    auth = EndpointAuth(this);
    dentalImage = EndpointDentalImage(this);
    document = EndpointDocument(this);
    hospital = EndpointHospital(this);
    receptionist = EndpointReceptionist(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAppointment appointment;

  late final EndpointAuth auth;

  late final EndpointDentalImage dentalImage;

  late final EndpointDocument document;

  late final EndpointHospital hospital;

  late final EndpointReceptionist receptionist;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'appointment': appointment,
    'auth': auth,
    'dentalImage': dentalImage,
    'document': document,
    'hospital': hospital,
    'receptionist': receptionist,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
