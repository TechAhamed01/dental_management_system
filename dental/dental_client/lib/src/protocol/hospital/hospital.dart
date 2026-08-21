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

abstract class Hospital implements _i1.SerializableModel {
  Hospital._({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.createdAt,
  });

  factory Hospital({
    int? id,
    required String name,
    required String address,
    required String phone,
    required String email,
    required bool isActive,
    required DateTime createdAt,
  }) = _HospitalImpl;

  factory Hospital.fromJson(Map<String, dynamic> jsonSerialization) {
    return Hospital(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
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

  String name;

  String address;

  String phone;

  String email;

  bool isActive;

  DateTime createdAt;

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Hospital copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Hospital',
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
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

class _HospitalImpl extends Hospital {
  _HospitalImpl({
    int? id,
    required String name,
    required String address,
    required String phone,
    required String email,
    required bool isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         address: address,
         phone: phone,
         email: email,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Hospital copyWith({
    Object? id = _Undefined,
    String? name,
    String? address,
    String? phone,
    String? email,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Hospital(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
