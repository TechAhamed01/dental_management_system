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
import 'auth/admin.dart' as _i2;
import 'auth/certificate.dart' as _i3;
import 'auth/dentist.dart' as _i4;
import 'auth/dentist_status.dart' as _i5;
import 'auth/patient.dart' as _i6;
import 'greetings/greeting.dart' as _i7;
import 'package:dental_client/src/protocol/auth/dentist.dart' as _i8;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i10;
export 'auth/admin.dart';
export 'auth/certificate.dart';
export 'auth/dentist.dart';
export 'auth/dentist_status.dart';
export 'auth/patient.dart';
export 'greetings/greeting.dart';
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

    if (t == _i2.Admin) {
      return _i2.Admin.fromJson(data) as T;
    }
    if (t == _i3.Certificate) {
      return _i3.Certificate.fromJson(data) as T;
    }
    if (t == _i4.Dentist) {
      return _i4.Dentist.fromJson(data) as T;
    }
    if (t == _i5.DentistStatus) {
      return _i5.DentistStatus.fromJson(data) as T;
    }
    if (t == _i6.Patient) {
      return _i6.Patient.fromJson(data) as T;
    }
    if (t == _i7.Greeting) {
      return _i7.Greeting.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Admin?>()) {
      return (data != null ? _i2.Admin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Certificate?>()) {
      return (data != null ? _i3.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Dentist?>()) {
      return (data != null ? _i4.Dentist.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DentistStatus?>()) {
      return (data != null ? _i5.DentistStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Patient?>()) {
      return (data != null ? _i6.Patient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Greeting?>()) {
      return (data != null ? _i7.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<_i8.Dentist>) {
      return (data as List).map((e) => deserialize<_i8.Dentist>(e)).toList()
          as T;
    }
    try {
      return _i9.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Admin => 'Admin',
      _i3.Certificate => 'Certificate',
      _i4.Dentist => 'Dentist',
      _i5.DentistStatus => 'DentistStatus',
      _i6.Patient => 'Patient',
      _i7.Greeting => 'Greeting',
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
      case _i2.Admin():
        return 'Admin';
      case _i3.Certificate():
        return 'Certificate';
      case _i4.Dentist():
        return 'Dentist';
      case _i5.DentistStatus():
        return 'DentistStatus';
      case _i6.Patient():
        return 'Patient';
      case _i7.Greeting():
        return 'Greeting';
    }
    className = _i9.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i10.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Admin') {
      return deserialize<_i2.Admin>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i3.Certificate>(data['data']);
    }
    if (dataClassName == 'Dentist') {
      return deserialize<_i4.Dentist>(data['data']);
    }
    if (dataClassName == 'DentistStatus') {
      return deserialize<_i5.DentistStatus>(data['data']);
    }
    if (dataClassName == 'Patient') {
      return deserialize<_i6.Patient>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i7.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i9.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i10.Protocol().deserializeByClassName(data);
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
      return _i9.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i10.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
