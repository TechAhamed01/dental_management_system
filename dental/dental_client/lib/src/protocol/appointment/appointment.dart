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
import '../hospital/hospital.dart' as _i3;
import '../auth/dentist.dart' as _i4;
import '../appointment/appointment_status.dart' as _i5;
import 'package:dental_client/src/protocol/protocol.dart' as _i6;

abstract class Appointment implements _i1.SerializableModel {
  Appointment._({
    this.id,
    required this.patientId,
    this.patient,
    required this.hospitalId,
    this.hospital,
    this.dentistId,
    this.dentist,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int hospitalId,
    _i3.Hospital? hospital,
    int? dentistId,
    _i4.Dentist? dentist,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String reason,
    required _i5.AppointmentStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppointmentImpl;

  factory Appointment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Appointment(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      patient: jsonSerialization['patient'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Patient>(
              jsonSerialization['patient'],
            ),
      hospitalId: jsonSerialization['hospitalId'] as int,
      hospital: jsonSerialization['hospital'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Hospital>(
              jsonSerialization['hospital'],
            ),
      dentistId: jsonSerialization['dentistId'] as int?,
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Dentist>(
              jsonSerialization['dentist'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      reason: jsonSerialization['reason'] as String,
      status: _i5.AppointmentStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int patientId;

  _i2.Patient? patient;

  int hospitalId;

  _i3.Hospital? hospital;

  int? dentistId;

  _i4.Dentist? dentist;

  DateTime date;

  String startTime;

  String endTime;

  String reason;

  _i5.AppointmentStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Appointment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Appointment copyWith({
    int? id,
    int? patientId,
    _i2.Patient? patient,
    int? hospitalId,
    _i3.Hospital? hospital,
    int? dentistId,
    _i4.Dentist? dentist,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? reason,
    _i5.AppointmentStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Appointment',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (patient != null) 'patient': patient?.toJson(),
      'hospitalId': hospitalId,
      if (hospital != null) 'hospital': hospital?.toJson(),
      if (dentistId != null) 'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJson(),
      'date': date.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppointmentImpl extends Appointment {
  _AppointmentImpl({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int hospitalId,
    _i3.Hospital? hospital,
    int? dentistId,
    _i4.Dentist? dentist,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String reason,
    required _i5.AppointmentStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         patientId: patientId,
         patient: patient,
         hospitalId: hospitalId,
         hospital: hospital,
         dentistId: dentistId,
         dentist: dentist,
         date: date,
         startTime: startTime,
         endTime: endTime,
         reason: reason,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Appointment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Appointment copyWith({
    Object? id = _Undefined,
    int? patientId,
    Object? patient = _Undefined,
    int? hospitalId,
    Object? hospital = _Undefined,
    Object? dentistId = _Undefined,
    Object? dentist = _Undefined,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? reason,
    _i5.AppointmentStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Appointment(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      patient: patient is _i2.Patient? ? patient : this.patient?.copyWith(),
      hospitalId: hospitalId ?? this.hospitalId,
      hospital: hospital is _i3.Hospital?
          ? hospital
          : this.hospital?.copyWith(),
      dentistId: dentistId is int? ? dentistId : this.dentistId,
      dentist: dentist is _i4.Dentist? ? dentist : this.dentist?.copyWith(),
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
