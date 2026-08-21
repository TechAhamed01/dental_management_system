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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'appointment/appointment.dart' as _i2;
import 'appointment/appointment_status.dart' as _i3;
import 'auth/admin.dart' as _i4;
import 'auth/audit_log.dart' as _i5;
import 'auth/auth_response.dart' as _i6;
import 'auth/certificate.dart' as _i7;
import 'auth/dashboard_stats.dart' as _i8;
import 'auth/dentist.dart' as _i9;
import 'auth/dentist_status.dart' as _i10;
import 'auth/patient.dart' as _i11;
import 'dentist_document/dentist_document.dart' as _i12;
import 'greetings/greeting.dart' as _i13;
import 'hospital/hospital.dart' as _i14;
import 'hospital/receptionist.dart' as _i15;
import 'package:dental_client/src/protocol/appointment/appointment.dart'
    as _i16;
import 'package:dental_client/src/protocol/auth/dentist.dart' as _i17;
import 'package:dental_client/src/protocol/auth/audit_log.dart' as _i18;
import 'package:dental_client/src/protocol/auth/patient.dart' as _i19;
import 'package:dental_client/src/protocol/dentist_document/dentist_document.dart'
    as _i20;
import 'package:dental_client/src/protocol/hospital/hospital.dart' as _i21;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i22;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i23;
export 'appointment/appointment.dart';
export 'appointment/appointment_status.dart';
export 'auth/admin.dart';
export 'auth/audit_log.dart';
export 'auth/auth_response.dart';
export 'auth/certificate.dart';
export 'auth/dashboard_stats.dart';
export 'auth/dentist.dart';
export 'auth/dentist_status.dart';
export 'auth/patient.dart';
export 'dentist_document/dentist_document.dart';
export 'greetings/greeting.dart';
export 'hospital/hospital.dart';
export 'hospital/receptionist.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Appointment) {
      return _i2.Appointment.fromJson(data) as T;
    }
    if (t == _i3.AppointmentStatus) {
      return _i3.AppointmentStatus.fromJson(data) as T;
    }
    if (t == _i4.Admin) {
      return _i4.Admin.fromJson(data) as T;
    }
    if (t == _i5.AuditLog) {
      return _i5.AuditLog.fromJson(data) as T;
    }
    if (t == _i6.AuthResponse) {
      return _i6.AuthResponse.fromJson(data) as T;
    }
    if (t == _i7.Certificate) {
      return _i7.Certificate.fromJson(data) as T;
    }
    if (t == _i8.DashboardStats) {
      return _i8.DashboardStats.fromJson(data) as T;
    }
    if (t == _i9.Dentist) {
      return _i9.Dentist.fromJson(data) as T;
    }
    if (t == _i10.DentistStatus) {
      return _i10.DentistStatus.fromJson(data) as T;
    }
    if (t == _i11.Patient) {
      return _i11.Patient.fromJson(data) as T;
    }
    if (t == _i12.DentistDocument) {
      return _i12.DentistDocument.fromJson(data) as T;
    }
    if (t == _i13.Greeting) {
      return _i13.Greeting.fromJson(data) as T;
    }
    if (t == _i14.Hospital) {
      return _i14.Hospital.fromJson(data) as T;
    }
    if (t == _i15.Receptionist) {
      return _i15.Receptionist.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Appointment?>()) {
      return (data != null ? _i2.Appointment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AppointmentStatus?>()) {
      return (data != null ? _i3.AppointmentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Admin?>()) {
      return (data != null ? _i4.Admin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuditLog?>()) {
      return (data != null ? _i5.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuthResponse?>()) {
      return (data != null ? _i6.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Certificate?>()) {
      return (data != null ? _i7.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DashboardStats?>()) {
      return (data != null ? _i8.DashboardStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Dentist?>()) {
      return (data != null ? _i9.Dentist.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.DentistStatus?>()) {
      return (data != null ? _i10.DentistStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Patient?>()) {
      return (data != null ? _i11.Patient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DentistDocument?>()) {
      return (data != null ? _i12.DentistDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Greeting?>()) {
      return (data != null ? _i13.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Hospital?>()) {
      return (data != null ? _i14.Hospital.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Receptionist?>()) {
      return (data != null ? _i15.Receptionist.fromJson(data) : null) as T;
    }
    if (t == List<_i16.Appointment>) {
      return (data as List)
              .map((e) => deserialize<_i16.Appointment>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.Dentist>) {
      return (data as List).map((e) => deserialize<_i17.Dentist>(e)).toList()
          as T;
    }
    if (t == List<_i18.AuditLog>) {
      return (data as List).map((e) => deserialize<_i18.AuditLog>(e)).toList()
          as T;
    }
    if (t == List<_i19.Patient>) {
      return (data as List).map((e) => deserialize<_i19.Patient>(e)).toList()
          as T;
    }
    if (t == List<_i20.DentistDocument>) {
      return (data as List)
              .map((e) => deserialize<_i20.DentistDocument>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.Hospital>) {
      return (data as List).map((e) => deserialize<_i21.Hospital>(e)).toList()
          as T;
    }
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i23.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Appointment => 'Appointment',
      _i3.AppointmentStatus => 'AppointmentStatus',
      _i4.Admin => 'Admin',
      _i5.AuditLog => 'AuditLog',
      _i6.AuthResponse => 'AuthResponse',
      _i7.Certificate => 'Certificate',
      _i8.DashboardStats => 'DashboardStats',
      _i9.Dentist => 'Dentist',
      _i10.DentistStatus => 'DentistStatus',
      _i11.Patient => 'Patient',
      _i12.DentistDocument => 'DentistDocument',
      _i13.Greeting => 'Greeting',
      _i14.Hospital => 'Hospital',
      _i15.Receptionist => 'Receptionist',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('dental.', '');
    }

    switch (data) {
      case _i2.Appointment():
        return 'Appointment';
      case _i3.AppointmentStatus():
        return 'AppointmentStatus';
      case _i4.Admin():
        return 'Admin';
      case _i5.AuditLog():
        return 'AuditLog';
      case _i6.AuthResponse():
        return 'AuthResponse';
      case _i7.Certificate():
        return 'Certificate';
      case _i8.DashboardStats():
        return 'DashboardStats';
      case _i9.Dentist():
        return 'Dentist';
      case _i10.DentistStatus():
        return 'DentistStatus';
      case _i11.Patient():
        return 'Patient';
      case _i12.DentistDocument():
        return 'DentistDocument';
      case _i13.Greeting():
        return 'Greeting';
      case _i14.Hospital():
        return 'Hospital';
      case _i15.Receptionist():
        return 'Receptionist';
    }
    className = _i22.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i23.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Appointment') {
      return deserialize<_i2.Appointment>(data['data']);
    }
    if (dataClassName == 'AppointmentStatus') {
      return deserialize<_i3.AppointmentStatus>(data['data']);
    }
    if (dataClassName == 'Admin') {
      return deserialize<_i4.Admin>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i5.AuditLog>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i6.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i7.Certificate>(data['data']);
    }
    if (dataClassName == 'DashboardStats') {
      return deserialize<_i8.DashboardStats>(data['data']);
    }
    if (dataClassName == 'Dentist') {
      return deserialize<_i9.Dentist>(data['data']);
    }
    if (dataClassName == 'DentistStatus') {
      return deserialize<_i10.DentistStatus>(data['data']);
    }
    if (dataClassName == 'Patient') {
      return deserialize<_i11.Patient>(data['data']);
    }
    if (dataClassName == 'DentistDocument') {
      return deserialize<_i12.DentistDocument>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i13.Greeting>(data['data']);
    }
    if (dataClassName == 'Hospital') {
      return deserialize<_i14.Hospital>(data['data']);
    }
    if (dataClassName == 'Receptionist') {
      return deserialize<_i15.Receptionist>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i22.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i23.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i22.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i23.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
