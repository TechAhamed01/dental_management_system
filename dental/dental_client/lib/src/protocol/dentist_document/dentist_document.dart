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

abstract class DentistDocument implements _i1.SerializableModel {
  DentistDocument._({
    this.id,
    required this.dentistId,
    this.dentist,
    required this.documentType,
    required this.fileName,
    required this.mimeType,
    required this.storageKey,
    required this.fileSize,
    required this.uploadedAt,
  });

  factory DentistDocument({
    int? id,
    required int dentistId,
    _i2.Dentist? dentist,
    required String documentType,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) = _DentistDocumentImpl;

  factory DentistDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return DentistDocument(
      id: jsonSerialization['id'] as int?,
      dentistId: jsonSerialization['dentistId'] as int,
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Dentist>(
              jsonSerialization['dentist'],
            ),
      documentType: jsonSerialization['documentType'] as String,
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

  int dentistId;

  _i2.Dentist? dentist;

  String documentType;

  String fileName;

  String mimeType;

  String storageKey;

  int fileSize;

  DateTime uploadedAt;

  /// Returns a shallow copy of this [DentistDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DentistDocument copyWith({
    int? id,
    int? dentistId,
    _i2.Dentist? dentist,
    String? documentType,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DentistDocument',
      if (id != null) 'id': id,
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJson(),
      'documentType': documentType,
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

class _DentistDocumentImpl extends DentistDocument {
  _DentistDocumentImpl({
    int? id,
    required int dentistId,
    _i2.Dentist? dentist,
    required String documentType,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) : super._(
         id: id,
         dentistId: dentistId,
         dentist: dentist,
         documentType: documentType,
         fileName: fileName,
         mimeType: mimeType,
         storageKey: storageKey,
         fileSize: fileSize,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [DentistDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DentistDocument copyWith({
    Object? id = _Undefined,
    int? dentistId,
    Object? dentist = _Undefined,
    String? documentType,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return DentistDocument(
      id: id is int? ? id : this.id,
      dentistId: dentistId ?? this.dentistId,
      dentist: dentist is _i2.Dentist? ? dentist : this.dentist?.copyWith(),
      documentType: documentType ?? this.documentType,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      storageKey: storageKey ?? this.storageKey,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
