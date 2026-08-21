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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/appointment_endpoint.dart' as _i4;
import '../endpoints/auth_endpoint.dart' as _i5;
import '../endpoints/document_endpoint.dart' as _i6;
import '../endpoints/hospital_endpoint.dart' as _i7;
import '../endpoints/receptionist_endpoint.dart' as _i8;
import '../greetings/greeting_endpoint.dart' as _i9;
import 'package:dental_server/src/generated/hospital/hospital.dart' as _i10;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i11;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'appointment': _i4.AppointmentEndpoint()
        ..initialize(
          server,
          'appointment',
          null,
        ),
      'auth': _i5.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'document': _i6.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'hospital': _i7.HospitalEndpoint()
        ..initialize(
          server,
          'hospital',
          null,
        ),
      'receptionist': _i8.ReceptionistEndpoint()
        ..initialize(
          server,
          'receptionist',
          null,
        ),
      'greeting': _i9.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['appointment'] = _i1.EndpointConnector(
      name: 'appointment',
      endpoint: endpoints['appointment']!,
      methodConnectors: {
        'createAppointment': _i1.MethodConnector(
          name: 'createAppointment',
          params: {
            'hospitalId': _i1.ParameterDescription(
              name: 'hospitalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'startTime': _i1.ParameterDescription(
              name: 'startTime',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'endTime': _i1.ParameterDescription(
              name: 'endTime',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .createAppointment(
                    session,
                    params['hospitalId'],
                    params['date'],
                    params['startTime'],
                    params['endTime'],
                    params['reason'],
                  ),
        ),
        'getPatientAppointments': _i1.MethodConnector(
          name: 'getPatientAppointments',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .getPatientAppointments(session),
        ),
        'cancelPatientAppointment': _i1.MethodConnector(
          name: 'cancelPatientAppointment',
          params: {
            'appointmentId': _i1.ParameterDescription(
              name: 'appointmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .cancelPatientAppointment(
                    session,
                    params['appointmentId'],
                  ),
        ),
        'getHospitalAppointments': _i1.MethodConnector(
          name: 'getHospitalAppointments',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .getHospitalAppointments(session),
        ),
        'getHospitalAppointmentDetails': _i1.MethodConnector(
          name: 'getHospitalAppointmentDetails',
          params: {
            'appointmentId': _i1.ParameterDescription(
              name: 'appointmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .getHospitalAppointmentDetails(
                    session,
                    params['appointmentId'],
                  ),
        ),
        'getAvailableDentistsForAppointment': _i1.MethodConnector(
          name: 'getAvailableDentistsForAppointment',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .getAvailableDentistsForAppointment(session),
        ),
        'allocateDentist': _i1.MethodConnector(
          name: 'allocateDentist',
          params: {
            'appointmentId': _i1.ParameterDescription(
              name: 'appointmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .allocateDentist(
                    session,
                    params['appointmentId'],
                    params['dentistId'],
                  ),
        ),
        'getDentistAppointments': _i1.MethodConnector(
          name: 'getDentistAppointments',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appointment'] as _i4.AppointmentEndpoint)
                  .getDentistAppointments(session),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'patientRegister': _i1.MethodConnector(
          name: 'patientRegister',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).patientRegister(
                    session,
                    params['fullName'],
                    params['email'],
                    params['phone'],
                    params['password'],
                  ),
        ),
        'patientLogin': _i1.MethodConnector(
          name: 'patientLogin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).patientLogin(
                session,
                params['email'],
                params['password'],
              ),
        ),
        'patientLogout': _i1.MethodConnector(
          name: 'patientLogout',
          params: {
            'patientId': _i1.ParameterDescription(
              name: 'patientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).patientLogout(
                session,
                params['patientId'],
              ),
        ),
        'patientRefreshToken': _i1.MethodConnector(
          name: 'patientRefreshToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).patientRefreshToken(
                    session,
                    params['refreshToken'],
                  ),
        ),
        'dentistRegister': _i1.MethodConnector(
          name: 'dentistRegister',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dateOfBirth': _i1.ParameterDescription(
              name: 'dateOfBirth',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'licenseNumber': _i1.ParameterDescription(
              name: 'licenseNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'specialization': _i1.ParameterDescription(
              name: 'specialization',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'qualification': _i1.ParameterDescription(
              name: 'qualification',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'experience': _i1.ParameterDescription(
              name: 'experience',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clinicName': _i1.ParameterDescription(
              name: 'clinicName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clinicAddress': _i1.ParameterDescription(
              name: 'clinicAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'profilePhotoUrl': _i1.ParameterDescription(
              name: 'profilePhotoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'registrationFileUrl': _i1.ParameterDescription(
              name: 'registrationFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'degreeFileUrl': _i1.ParameterDescription(
              name: 'degreeFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'idFileUrl': _i1.ParameterDescription(
              name: 'idFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isTermsAccepted': _i1.ParameterDescription(
              name: 'isTermsAccepted',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).dentistRegister(
                    session,
                    params['fullName'],
                    params['email'],
                    params['phone'],
                    params['password'],
                    params['dateOfBirth'],
                    params['licenseNumber'],
                    params['specialization'],
                    params['qualification'],
                    params['experience'],
                    params['clinicName'],
                    params['clinicAddress'],
                    params['profilePhotoUrl'],
                    params['registrationFileUrl'],
                    params['degreeFileUrl'],
                    params['idFileUrl'],
                    params['isTermsAccepted'],
                  ),
        ),
        'dentistLogin': _i1.MethodConnector(
          name: 'dentistLogin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).dentistLogin(
                session,
                params['email'],
                params['password'],
              ),
        ),
        'dentistLogout': _i1.MethodConnector(
          name: 'dentistLogout',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).dentistLogout(
                session,
                params['dentistId'],
              ),
        ),
        'adminLogin': _i1.MethodConnector(
          name: 'adminLogin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).adminLogin(
                session,
                params['email'],
                params['password'],
              ),
        ),
        'adminLogout': _i1.MethodConnector(
          name: 'adminLogout',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).adminLogout(
                session,
                params['adminId'],
              ),
        ),
        'refreshAuthToken': _i1.MethodConnector(
          name: 'refreshAuthToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).refreshAuthToken(
                    session,
                    params['refreshToken'],
                  ),
        ),
        'getPendingDentists': _i1.MethodConnector(
          name: 'getPendingDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getPendingDentists(session),
        ),
        'approveDentist': _i1.MethodConnector(
          name: 'approveDentist',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'adminEmail': _i1.ParameterDescription(
              name: 'adminEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).approveDentist(
                session,
                params['dentistId'],
                adminEmail: params['adminEmail'],
              ),
        ),
        'rejectDentist': _i1.MethodConnector(
          name: 'rejectDentist',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'adminEmail': _i1.ParameterDescription(
              name: 'adminEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).rejectDentist(
                session,
                params['dentistId'],
                adminEmail: params['adminEmail'],
                reason: params['reason'],
              ),
        ),
        'suspendDentist': _i1.MethodConnector(
          name: 'suspendDentist',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'endsAt': _i1.ParameterDescription(
              name: 'endsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'adminEmail': _i1.ParameterDescription(
              name: 'adminEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).suspendDentist(
                session,
                params['dentistId'],
                params['endsAt'],
                params['reason'],
                adminEmail: params['adminEmail'],
              ),
        ),
        'terminateDentist': _i1.MethodConnector(
          name: 'terminateDentist',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'adminEmail': _i1.ParameterDescription(
              name: 'adminEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).terminateDentist(
                    session,
                    params['dentistId'],
                    params['reason'],
                    adminEmail: params['adminEmail'],
                  ),
        ),
        'getDentistAuditLogs': _i1.MethodConnector(
          name: 'getDentistAuditLogs',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).getDentistAuditLogs(
                    session,
                    params['dentistId'],
                  ),
        ),
        'logPdfDownload': _i1.MethodConnector(
          name: 'logPdfDownload',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'adminEmail': _i1.ParameterDescription(
              name: 'adminEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).logPdfDownload(
                session,
                params['dentistId'],
                adminEmail: params['adminEmail'],
              ),
        ),
        'searchDentistByCode': _i1.MethodConnector(
          name: 'searchDentistByCode',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).searchDentistByCode(
                    session,
                    params['code'],
                  ),
        ),
        'getDashboardStats': _i1.MethodConnector(
          name: 'getDashboardStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getDashboardStats(session),
        ),
        'getAllPatients': _i1.MethodConnector(
          name: 'getAllPatients',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).getAllPatients(
                session,
              ),
        ),
        'getAllDentists': _i1.MethodConnector(
          name: 'getAllDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).getAllDentists(
                session,
              ),
        ),
        'getApprovedDentists': _i1.MethodConnector(
          name: 'getApprovedDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getApprovedDentists(session),
        ),
        'getRejectedDentists': _i1.MethodConnector(
          name: 'getRejectedDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getRejectedDentists(session),
        ),
        'getSuspendedDentists': _i1.MethodConnector(
          name: 'getSuspendedDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getSuspendedDentists(session),
        ),
        'getTerminatedDentists': _i1.MethodConnector(
          name: 'getTerminatedDentists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint)
                  .getTerminatedDentists(session),
        ),
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'getDentistDocuments': _i1.MethodConnector(
          name: 'getDentistDocuments',
          params: {
            'dentistId': _i1.ParameterDescription(
              name: 'dentistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i6.DocumentEndpoint)
                  .getDentistDocuments(
                    session,
                    params['dentistId'],
                  ),
        ),
        'downloadDocument': _i1.MethodConnector(
          name: 'downloadDocument',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i6.DocumentEndpoint)
                  .downloadDocument(
                    session,
                    params['documentId'],
                  ),
        ),
      },
    );
    connectors['hospital'] = _i1.EndpointConnector(
      name: 'hospital',
      endpoint: endpoints['hospital']!,
      methodConnectors: {
        'createHospital': _i1.MethodConnector(
          name: 'createHospital',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'address': _i1.ParameterDescription(
              name: 'address',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hospital'] as _i7.HospitalEndpoint)
                  .createHospital(
                    session,
                    params['name'],
                    params['address'],
                    params['phone'],
                    params['email'],
                  ),
        ),
        'getHospital': _i1.MethodConnector(
          name: 'getHospital',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hospital'] as _i7.HospitalEndpoint).getHospital(
                    session,
                    params['id'],
                  ),
        ),
        'listActiveHospitals': _i1.MethodConnector(
          name: 'listActiveHospitals',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hospital'] as _i7.HospitalEndpoint)
                  .listActiveHospitals(session),
        ),
        'updateHospital': _i1.MethodConnector(
          name: 'updateHospital',
          params: {
            'hospital': _i1.ParameterDescription(
              name: 'hospital',
              type: _i1.getType<_i10.Hospital>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hospital'] as _i7.HospitalEndpoint)
                  .updateHospital(
                    session,
                    params['hospital'],
                  ),
        ),
      },
    );
    connectors['receptionist'] = _i1.EndpointConnector(
      name: 'receptionist',
      endpoint: endpoints['receptionist']!,
      methodConnectors: {
        'receptionistLogin': _i1.MethodConnector(
          name: 'receptionistLogin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['receptionist'] as _i8.ReceptionistEndpoint)
                  .receptionistLogin(
                    session,
                    params['email'],
                    params['password'],
                  ),
        ),
        'receptionistLogout': _i1.MethodConnector(
          name: 'receptionistLogout',
          params: {
            'receptionistId': _i1.ParameterDescription(
              name: 'receptionistId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['receptionist'] as _i8.ReceptionistEndpoint)
                  .receptionistLogout(
                    session,
                    params['receptionistId'],
                  ),
        ),
        'createReceptionist': _i1.MethodConnector(
          name: 'createReceptionist',
          params: {
            'hospitalId': _i1.ParameterDescription(
              name: 'hospitalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['receptionist'] as _i8.ReceptionistEndpoint)
                  .createReceptionist(
                    session,
                    params['hospitalId'],
                    params['fullName'],
                    params['email'],
                    params['phone'],
                    params['password'],
                  ),
        ),
        'receptionistRegisterDentist': _i1.MethodConnector(
          name: 'receptionistRegisterDentist',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dateOfBirth': _i1.ParameterDescription(
              name: 'dateOfBirth',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'licenseNumber': _i1.ParameterDescription(
              name: 'licenseNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'specialization': _i1.ParameterDescription(
              name: 'specialization',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'qualification': _i1.ParameterDescription(
              name: 'qualification',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'experience': _i1.ParameterDescription(
              name: 'experience',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clinicName': _i1.ParameterDescription(
              name: 'clinicName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clinicAddress': _i1.ParameterDescription(
              name: 'clinicAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'profilePhotoUrl': _i1.ParameterDescription(
              name: 'profilePhotoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'registrationFileUrl': _i1.ParameterDescription(
              name: 'registrationFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'degreeFileUrl': _i1.ParameterDescription(
              name: 'degreeFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'idFileUrl': _i1.ParameterDescription(
              name: 'idFileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isTermsAccepted': _i1.ParameterDescription(
              name: 'isTermsAccepted',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['receptionist'] as _i8.ReceptionistEndpoint)
                  .receptionistRegisterDentist(
                    session,
                    params['fullName'],
                    params['email'],
                    params['phone'],
                    params['password'],
                    params['dateOfBirth'],
                    params['licenseNumber'],
                    params['specialization'],
                    params['qualification'],
                    params['experience'],
                    params['clinicName'],
                    params['clinicAddress'],
                    params['profilePhotoUrl'],
                    params['registrationFileUrl'],
                    params['degreeFileUrl'],
                    params['idFileUrl'],
                    params['isTermsAccepted'],
                  ),
        ),
        'getDentistsForHospital': _i1.MethodConnector(
          name: 'getDentistsForHospital',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['receptionist'] as _i8.ReceptionistEndpoint)
                  .getDentistsForHospital(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i9.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }
}
