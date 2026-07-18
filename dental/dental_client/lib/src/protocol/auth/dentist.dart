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
import '../auth/dentist_status.dart' as _i2;

abstract class Dentist implements _i1.SerializableModel {
  Dentist._({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.passwordHash,
    this.dateOfBirth,
    required this.licenseNumber,
    required this.specialization,
    this.qualification,
    required this.experience,
    required this.clinicName,
    required this.clinicAddress,
    this.profilePhotoUrl,
    this.registrationFileUrl,
    this.degreeFileUrl,
    this.idFileUrl,
    required this.isTermsAccepted,
    required this.status,
  });

  factory Dentist({
    int? id,
    required String fullName,
    required String email,
    required String phone,
    required String passwordHash,
    String? dateOfBirth,
    required String licenseNumber,
    required String specialization,
    String? qualification,
    required int experience,
    required String clinicName,
    required String clinicAddress,
    String? profilePhotoUrl,
    String? registrationFileUrl,
    String? degreeFileUrl,
    String? idFileUrl,
    required bool isTermsAccepted,
    required _i2.DentistStatus status,
  }) = _DentistImpl;

  factory Dentist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dentist(
      id: jsonSerialization['id'] as int?,
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      phone: jsonSerialization['phone'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      dateOfBirth: jsonSerialization['dateOfBirth'] as String?,
      licenseNumber: jsonSerialization['licenseNumber'] as String,
      specialization: jsonSerialization['specialization'] as String,
      qualification: jsonSerialization['qualification'] as String?,
      experience: jsonSerialization['experience'] as int,
      clinicName: jsonSerialization['clinicName'] as String,
      clinicAddress: jsonSerialization['clinicAddress'] as String,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      registrationFileUrl: jsonSerialization['registrationFileUrl'] as String?,
      degreeFileUrl: jsonSerialization['degreeFileUrl'] as String?,
      idFileUrl: jsonSerialization['idFileUrl'] as String?,
      isTermsAccepted: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isTermsAccepted'],
      ),
      status: _i2.DentistStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fullName;

  String email;

  String phone;

  String passwordHash;

  String? dateOfBirth;

  String licenseNumber;

  String specialization;

  String? qualification;

  int experience;

  String clinicName;

  String clinicAddress;

  String? profilePhotoUrl;

  String? registrationFileUrl;

  String? degreeFileUrl;

  String? idFileUrl;

  bool isTermsAccepted;

  _i2.DentistStatus status;

  /// Returns a shallow copy of this [Dentist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dentist copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phone,
    String? passwordHash,
    String? dateOfBirth,
    String? licenseNumber,
    String? specialization,
    String? qualification,
    int? experience,
    String? clinicName,
    String? clinicAddress,
    String? profilePhotoUrl,
    String? registrationFileUrl,
    String? degreeFileUrl,
    String? idFileUrl,
    bool? isTermsAccepted,
    _i2.DentistStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dentist',
      if (id != null) 'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'passwordHash': passwordHash,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      if (qualification != null) 'qualification': qualification,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (registrationFileUrl != null)
        'registrationFileUrl': registrationFileUrl,
      if (degreeFileUrl != null) 'degreeFileUrl': degreeFileUrl,
      if (idFileUrl != null) 'idFileUrl': idFileUrl,
      'isTermsAccepted': isTermsAccepted,
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DentistImpl extends Dentist {
  _DentistImpl({
    int? id,
    required String fullName,
    required String email,
    required String phone,
    required String passwordHash,
    String? dateOfBirth,
    required String licenseNumber,
    required String specialization,
    String? qualification,
    required int experience,
    required String clinicName,
    required String clinicAddress,
    String? profilePhotoUrl,
    String? registrationFileUrl,
    String? degreeFileUrl,
    String? idFileUrl,
    required bool isTermsAccepted,
    required _i2.DentistStatus status,
  }) : super._(
         id: id,
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
         status: status,
       );

  /// Returns a shallow copy of this [Dentist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dentist copyWith({
    Object? id = _Undefined,
    String? fullName,
    String? email,
    String? phone,
    String? passwordHash,
    Object? dateOfBirth = _Undefined,
    String? licenseNumber,
    String? specialization,
    Object? qualification = _Undefined,
    int? experience,
    String? clinicName,
    String? clinicAddress,
    Object? profilePhotoUrl = _Undefined,
    Object? registrationFileUrl = _Undefined,
    Object? degreeFileUrl = _Undefined,
    Object? idFileUrl = _Undefined,
    bool? isTermsAccepted,
    _i2.DentistStatus? status,
  }) {
    return Dentist(
      id: id is int? ? id : this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      passwordHash: passwordHash ?? this.passwordHash,
      dateOfBirth: dateOfBirth is String? ? dateOfBirth : this.dateOfBirth,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      specialization: specialization ?? this.specialization,
      qualification: qualification is String?
          ? qualification
          : this.qualification,
      experience: experience ?? this.experience,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      registrationFileUrl: registrationFileUrl is String?
          ? registrationFileUrl
          : this.registrationFileUrl,
      degreeFileUrl: degreeFileUrl is String?
          ? degreeFileUrl
          : this.degreeFileUrl,
      idFileUrl: idFileUrl is String? ? idFileUrl : this.idFileUrl,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      status: status ?? this.status,
    );
  }
}
