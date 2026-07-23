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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class DashboardStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardStats._({
    required this.totalPatients,
    required this.totalDoctors,
    required this.pendingDoctors,
    required this.approvedDoctors,
    required this.rejectedDoctors,
    required this.suspendedDoctors,
    required this.terminatedDoctors,
  });

  factory DashboardStats({
    required int totalPatients,
    required int totalDoctors,
    required int pendingDoctors,
    required int approvedDoctors,
    required int rejectedDoctors,
    required int suspendedDoctors,
    required int terminatedDoctors,
  }) = _DashboardStatsImpl;

  factory DashboardStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardStats(
      totalPatients: jsonSerialization['totalPatients'] as int,
      totalDoctors: jsonSerialization['totalDoctors'] as int,
      pendingDoctors: jsonSerialization['pendingDoctors'] as int,
      approvedDoctors: jsonSerialization['approvedDoctors'] as int,
      rejectedDoctors: jsonSerialization['rejectedDoctors'] as int,
      suspendedDoctors: jsonSerialization['suspendedDoctors'] as int,
      terminatedDoctors: jsonSerialization['terminatedDoctors'] as int,
    );
  }

  int totalPatients;

  int totalDoctors;

  int pendingDoctors;

  int approvedDoctors;

  int rejectedDoctors;

  int suspendedDoctors;

  int terminatedDoctors;

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardStats copyWith({
    int? totalPatients,
    int? totalDoctors,
    int? pendingDoctors,
    int? approvedDoctors,
    int? rejectedDoctors,
    int? suspendedDoctors,
    int? terminatedDoctors,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardStats',
      'totalPatients': totalPatients,
      'totalDoctors': totalDoctors,
      'pendingDoctors': pendingDoctors,
      'approvedDoctors': approvedDoctors,
      'rejectedDoctors': rejectedDoctors,
      'suspendedDoctors': suspendedDoctors,
      'terminatedDoctors': terminatedDoctors,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardStats',
      'totalPatients': totalPatients,
      'totalDoctors': totalDoctors,
      'pendingDoctors': pendingDoctors,
      'approvedDoctors': approvedDoctors,
      'rejectedDoctors': rejectedDoctors,
      'suspendedDoctors': suspendedDoctors,
      'terminatedDoctors': terminatedDoctors,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardStatsImpl extends DashboardStats {
  _DashboardStatsImpl({
    required int totalPatients,
    required int totalDoctors,
    required int pendingDoctors,
    required int approvedDoctors,
    required int rejectedDoctors,
    required int suspendedDoctors,
    required int terminatedDoctors,
  }) : super._(
         totalPatients: totalPatients,
         totalDoctors: totalDoctors,
         pendingDoctors: pendingDoctors,
         approvedDoctors: approvedDoctors,
         rejectedDoctors: rejectedDoctors,
         suspendedDoctors: suspendedDoctors,
         terminatedDoctors: terminatedDoctors,
       );

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardStats copyWith({
    int? totalPatients,
    int? totalDoctors,
    int? pendingDoctors,
    int? approvedDoctors,
    int? rejectedDoctors,
    int? suspendedDoctors,
    int? terminatedDoctors,
  }) {
    return DashboardStats(
      totalPatients: totalPatients ?? this.totalPatients,
      totalDoctors: totalDoctors ?? this.totalDoctors,
      pendingDoctors: pendingDoctors ?? this.pendingDoctors,
      approvedDoctors: approvedDoctors ?? this.approvedDoctors,
      rejectedDoctors: rejectedDoctors ?? this.rejectedDoctors,
      suspendedDoctors: suspendedDoctors ?? this.suspendedDoctors,
      terminatedDoctors: terminatedDoctors ?? this.terminatedDoctors,
    );
  }
}
