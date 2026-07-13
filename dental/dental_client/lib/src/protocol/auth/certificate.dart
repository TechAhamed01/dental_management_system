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
import '../auth/dentist.dart' as _i2;
import 'package:dental_client/src/protocol/protocol.dart' as _i3;

abstract class Certificate implements _i1.SerializableModel {
  Certificate._({
    this.id,
    required this.dentistId,
    this.dentist,
    required this.fileUrl,
  });

  factory Certificate({
    int? id,
    required int dentistId,
    _i2.Dentist? dentist,
    required String fileUrl,
  }) = _CertificateImpl;

  factory Certificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Certificate(
      id: jsonSerialization['id'] as int?,
      dentistId: jsonSerialization['dentistId'] as int,
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Dentist>(
              jsonSerialization['dentist'],
            ),
      fileUrl: jsonSerialization['fileUrl'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int dentistId;

  _i2.Dentist? dentist;

  String fileUrl;

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Certificate copyWith({
    int? id,
    int? dentistId,
    _i2.Dentist? dentist,
    String? fileUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Certificate',
      if (id != null) 'id': id,
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJson(),
      'fileUrl': fileUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateImpl extends Certificate {
  _CertificateImpl({
    int? id,
    required int dentistId,
    _i2.Dentist? dentist,
    required String fileUrl,
  }) : super._(
         id: id,
         dentistId: dentistId,
         dentist: dentist,
         fileUrl: fileUrl,
       );

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Certificate copyWith({
    Object? id = _Undefined,
    int? dentistId,
    Object? dentist = _Undefined,
    String? fileUrl,
  }) {
    return Certificate(
      id: id is int? ? id : this.id,
      dentistId: dentistId ?? this.dentistId,
      dentist: dentist is _i2.Dentist? ? dentist : this.dentist?.copyWith(),
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
