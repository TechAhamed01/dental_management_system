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
import '../auth/patient.dart' as _i2;
import '../appointment/appointment.dart' as _i3;
import '../auth/dentist.dart' as _i4;
import 'package:dental_client/src/protocol/protocol.dart' as _i5;

abstract class DentalImage implements _i1.SerializableModel {
  DentalImage._({
    this.id,
    required this.patientId,
    this.patient,
    required this.appointmentId,
    this.appointment,
    required this.dentistId,
    this.dentist,
    required this.fileName,
    required this.mimeType,
    required this.storageKey,
    required this.fileSize,
    required this.uploadedAt,
  });

  factory DentalImage({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int appointmentId,
    _i3.Appointment? appointment,
    required int dentistId,
    _i4.Dentist? dentist,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) = _DentalImageImpl;

  factory DentalImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DentalImage(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      patient: jsonSerialization['patient'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Patient>(
              jsonSerialization['patient'],
            ),
      appointmentId: jsonSerialization['appointmentId'] as int,
      appointment: jsonSerialization['appointment'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Appointment>(
              jsonSerialization['appointment'],
            ),
      dentistId: jsonSerialization['dentistId'] as int,
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Dentist>(
              jsonSerialization['dentist'],
            ),
      fileName: jsonSerialization['fileName'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      fileSize: jsonSerialization['fileSize'] as int,
      uploadedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int patientId;

  _i2.Patient? patient;

  int appointmentId;

  _i3.Appointment? appointment;

  int dentistId;

  _i4.Dentist? dentist;

  String fileName;

  String mimeType;

  String storageKey;

  int fileSize;

  DateTime uploadedAt;

  /// Returns a shallow copy of this [DentalImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DentalImage copyWith({
    int? id,
    int? patientId,
    _i2.Patient? patient,
    int? appointmentId,
    _i3.Appointment? appointment,
    int? dentistId,
    _i4.Dentist? dentist,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DentalImage',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (patient != null) 'patient': patient?.toJson(),
      'appointmentId': appointmentId,
      if (appointment != null) 'appointment': appointment?.toJson(),
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJson(),
      'fileName': fileName,
      'mimeType': mimeType,
      'storageKey': storageKey,
      'fileSize': fileSize,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DentalImageImpl extends DentalImage {
  _DentalImageImpl({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int appointmentId,
    _i3.Appointment? appointment,
    required int dentistId,
    _i4.Dentist? dentist,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) : super._(
         id: id,
         patientId: patientId,
         patient: patient,
         appointmentId: appointmentId,
         appointment: appointment,
         dentistId: dentistId,
         dentist: dentist,
         fileName: fileName,
         mimeType: mimeType,
         storageKey: storageKey,
         fileSize: fileSize,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [DentalImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DentalImage copyWith({
    Object? id = _Undefined,
    int? patientId,
    Object? patient = _Undefined,
    int? appointmentId,
    Object? appointment = _Undefined,
    int? dentistId,
    Object? dentist = _Undefined,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return DentalImage(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      patient: patient is _i2.Patient? ? patient : this.patient?.copyWith(),
      appointmentId: appointmentId ?? this.appointmentId,
      appointment: appointment is _i3.Appointment?
          ? appointment
          : this.appointment?.copyWith(),
      dentistId: dentistId ?? this.dentistId,
      dentist: dentist is _i4.Dentist? ? dentist : this.dentist?.copyWith(),
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      storageKey: storageKey ?? this.storageKey,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
