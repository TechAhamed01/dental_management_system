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

abstract class DashboardStats implements _i1.SerializableModel {
  DashboardStats._({
    required this.totalPatients,
    required this.totalDoctors,
    required this.pendingDoctors,
    required this.approvedDoctors,
    required this.rejectedDoctors,
  });

  factory DashboardStats({
    required int totalPatients,
    required int totalDoctors,
    required int pendingDoctors,
    required int approvedDoctors,
    required int rejectedDoctors,
  }) = _DashboardStatsImpl;

  factory DashboardStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardStats(
      totalPatients: jsonSerialization['totalPatients'] as int,
      totalDoctors: jsonSerialization['totalDoctors'] as int,
      pendingDoctors: jsonSerialization['pendingDoctors'] as int,
      approvedDoctors: jsonSerialization['approvedDoctors'] as int,
      rejectedDoctors: jsonSerialization['rejectedDoctors'] as int,
    );
  }

  int totalPatients;

  int totalDoctors;

  int pendingDoctors;

  int approvedDoctors;

  int rejectedDoctors;

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardStats copyWith({
    int? totalPatients,
    int? totalDoctors,
    int? pendingDoctors,
    int? approvedDoctors,
    int? rejectedDoctors,
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
  }) : super._(
         totalPatients: totalPatients,
         totalDoctors: totalDoctors,
         pendingDoctors: pendingDoctors,
         approvedDoctors: approvedDoctors,
         rejectedDoctors: rejectedDoctors,
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
  }) {
    return DashboardStats(
      totalPatients: totalPatients ?? this.totalPatients,
      totalDoctors: totalDoctors ?? this.totalDoctors,
      pendingDoctors: pendingDoctors ?? this.pendingDoctors,
      approvedDoctors: approvedDoctors ?? this.approvedDoctors,
      rejectedDoctors: rejectedDoctors ?? this.rejectedDoctors,
    );
  }
}
