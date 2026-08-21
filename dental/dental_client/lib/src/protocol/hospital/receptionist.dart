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
import '../hospital/hospital.dart' as _i2;
import 'package:dental_client/src/protocol/protocol.dart' as _i3;

abstract class Receptionist implements _i1.SerializableModel {
  Receptionist._({
    this.id,
    required this.hospitalId,
    this.hospital,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.phone,
    required this.isActive,
    required this.createdAt,
  });

  factory Receptionist({
    int? id,
    required int hospitalId,
    _i2.Hospital? hospital,
    required String fullName,
    required String email,
    required String passwordHash,
    required String phone,
    required bool isActive,
    required DateTime createdAt,
  }) = _ReceptionistImpl;

  factory Receptionist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Receptionist(
      id: jsonSerialization['id'] as int?,
      hospitalId: jsonSerialization['hospitalId'] as int,
      hospital: jsonSerialization['hospital'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Hospital>(
              jsonSerialization['hospital'],
            ),
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      phone: jsonSerialization['phone'] as String,
      isActive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int hospitalId;

  _i2.Hospital? hospital;

  String fullName;

  String email;

  String passwordHash;

  String phone;

  bool isActive;

  DateTime createdAt;

  /// Returns a shallow copy of this [Receptionist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Receptionist copyWith({
    int? id,
    int? hospitalId,
    _i2.Hospital? hospital,
    String? fullName,
    String? email,
    String? passwordHash,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Receptionist',
      if (id != null) 'id': id,
      'hospitalId': hospitalId,
      if (hospital != null) 'hospital': hospital?.toJson(),
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReceptionistImpl extends Receptionist {
  _ReceptionistImpl({
    int? id,
    required int hospitalId,
    _i2.Hospital? hospital,
    required String fullName,
    required String email,
    required String passwordHash,
    required String phone,
    required bool isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         hospitalId: hospitalId,
         hospital: hospital,
         fullName: fullName,
         email: email,
         passwordHash: passwordHash,
         phone: phone,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Receptionist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Receptionist copyWith({
    Object? id = _Undefined,
    int? hospitalId,
    Object? hospital = _Undefined,
    String? fullName,
    String? email,
    String? passwordHash,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Receptionist(
      id: id is int? ? id : this.id,
      hospitalId: hospitalId ?? this.hospitalId,
      hospital: hospital is _i2.Hospital?
          ? hospital
          : this.hospital?.copyWith(),
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
