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
import '../auth/patient.dart' as _i2;
import '../auth/dentist.dart' as _i3;
import '../auth/admin.dart' as _i4;
import '../hospital/receptionist.dart' as _i5;
import 'package:dental_server/src/generated/protocol.dart' as _i6;

abstract class AuthResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AuthResponse._({
    required this.token,
    required this.refreshToken,
    this.patient,
    this.dentist,
    this.admin,
    this.receptionist,
  });

  factory AuthResponse({
    required String token,
    required String refreshToken,
    _i2.Patient? patient,
    _i3.Dentist? dentist,
    _i4.Admin? admin,
    _i5.Receptionist? receptionist,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      token: jsonSerialization['token'] as String,
      refreshToken: jsonSerialization['refreshToken'] as String,
      patient: jsonSerialization['patient'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Patient>(
              jsonSerialization['patient'],
            ),
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Dentist>(
              jsonSerialization['dentist'],
            ),
      admin: jsonSerialization['admin'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Admin>(jsonSerialization['admin']),
      receptionist: jsonSerialization['receptionist'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.Receptionist>(
              jsonSerialization['receptionist'],
            ),
    );
  }

  String token;

  String refreshToken;

  _i2.Patient? patient;

  _i3.Dentist? dentist;

  _i4.Admin? admin;

  _i5.Receptionist? receptionist;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    String? token,
    String? refreshToken,
    _i2.Patient? patient,
    _i3.Dentist? dentist,
    _i4.Admin? admin,
    _i5.Receptionist? receptionist,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthResponse',
      'token': token,
      'refreshToken': refreshToken,
      if (patient != null) 'patient': patient?.toJson(),
      if (dentist != null) 'dentist': dentist?.toJson(),
      if (admin != null) 'admin': admin?.toJson(),
      if (receptionist != null) 'receptionist': receptionist?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthResponse',
      'token': token,
      'refreshToken': refreshToken,
      if (patient != null) 'patient': patient?.toJsonForProtocol(),
      if (dentist != null) 'dentist': dentist?.toJsonForProtocol(),
      if (admin != null) 'admin': admin?.toJsonForProtocol(),
      if (receptionist != null)
        'receptionist': receptionist?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required String token,
    required String refreshToken,
    _i2.Patient? patient,
    _i3.Dentist? dentist,
    _i4.Admin? admin,
    _i5.Receptionist? receptionist,
  }) : super._(
         token: token,
         refreshToken: refreshToken,
         patient: patient,
         dentist: dentist,
         admin: admin,
         receptionist: receptionist,
       );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    String? token,
    String? refreshToken,
    Object? patient = _Undefined,
    Object? dentist = _Undefined,
    Object? admin = _Undefined,
    Object? receptionist = _Undefined,
  }) {
    return AuthResponse(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      patient: patient is _i2.Patient? ? patient : this.patient?.copyWith(),
      dentist: dentist is _i3.Dentist? ? dentist : this.dentist?.copyWith(),
      admin: admin is _i4.Admin? ? admin : this.admin?.copyWith(),
      receptionist: receptionist is _i5.Receptionist?
          ? receptionist
          : this.receptionist?.copyWith(),
    );
  }
}
