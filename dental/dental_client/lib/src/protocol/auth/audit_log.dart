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

abstract class AuditLog implements _i1.SerializableModel {
  AuditLog._({
    this.id,
    required this.dentistId,
    required this.adminEmail,
    required this.action,
    this.reason,
    required this.timestamp,
  });

  factory AuditLog({
    int? id,
    required int dentistId,
    required String adminEmail,
    required String action,
    String? reason,
    required DateTime timestamp,
  }) = _AuditLogImpl;

  factory AuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditLog(
      id: jsonSerialization['id'] as int?,
      dentistId: jsonSerialization['dentistId'] as int,
      adminEmail: jsonSerialization['adminEmail'] as String,
      action: jsonSerialization['action'] as String,
      reason: jsonSerialization['reason'] as String?,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int dentistId;

  String adminEmail;

  String action;

  String? reason;

  DateTime timestamp;

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditLog copyWith({
    int? id,
    int? dentistId,
    String? adminEmail,
    String? action,
    String? reason,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditLog',
      if (id != null) 'id': id,
      'dentistId': dentistId,
      'adminEmail': adminEmail,
      'action': action,
      if (reason != null) 'reason': reason,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditLogImpl extends AuditLog {
  _AuditLogImpl({
    int? id,
    required int dentistId,
    required String adminEmail,
    required String action,
    String? reason,
    required DateTime timestamp,
  }) : super._(
         id: id,
         dentistId: dentistId,
         adminEmail: adminEmail,
         action: action,
         reason: reason,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditLog copyWith({
    Object? id = _Undefined,
    int? dentistId,
    String? adminEmail,
    String? action,
    Object? reason = _Undefined,
    DateTime? timestamp,
  }) {
    return AuditLog(
      id: id is int? ? id : this.id,
      dentistId: dentistId ?? this.dentistId,
      adminEmail: adminEmail ?? this.adminEmail,
      action: action ?? this.action,
      reason: reason is String? ? reason : this.reason,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
