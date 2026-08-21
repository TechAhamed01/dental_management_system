/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/patient.dart' as _i2;
import '../hospital/hospital.dart' as _i3;
import '../auth/dentist.dart' as _i4;
import '../appointment/appointment_status.dart' as _i5;
import 'package:dental_server/src/generated/protocol.dart' as _i6;

abstract class Appointment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = AppointmentTable();

  static const db = AppointmentRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Appointment',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (patient != null) 'patient': patient?.toJsonForProtocol(),
      'hospitalId': hospitalId,
      if (hospital != null) 'hospital': hospital?.toJsonForProtocol(),
      if (dentistId != null) 'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJsonForProtocol(),
      'date': date.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AppointmentInclude include({
    _i2.PatientInclude? patient,
    _i3.HospitalInclude? hospital,
    _i4.DentistInclude? dentist,
  }) {
    return AppointmentInclude._(
      patient: patient,
      hospital: hospital,
      dentist: dentist,
    );
  }

  static AppointmentIncludeList includeList({
    _i1.WhereExpressionBuilder<AppointmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppointmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppointmentTable>? orderByList,
    AppointmentInclude? include,
  }) {
    return AppointmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Appointment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Appointment.t),
      include: include,
    );
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

class AppointmentUpdateTable extends _i1.UpdateTable<AppointmentTable> {
  AppointmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> patientId(int value) => _i1.ColumnValue(
    table.patientId,
    value,
  );

  _i1.ColumnValue<int, int> hospitalId(int value) => _i1.ColumnValue(
    table.hospitalId,
    value,
  );

  _i1.ColumnValue<int, int> dentistId(int? value) => _i1.ColumnValue(
    table.dentistId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<String, String> startTime(String value) => _i1.ColumnValue(
    table.startTime,
    value,
  );

  _i1.ColumnValue<String, String> endTime(String value) => _i1.ColumnValue(
    table.endTime,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<_i5.AppointmentStatus, _i5.AppointmentStatus> status(
    _i5.AppointmentStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class AppointmentTable extends _i1.Table<int?> {
  AppointmentTable({super.tableRelation}) : super(tableName: 'appointment') {
    updateTable = AppointmentUpdateTable(this);
    patientId = _i1.ColumnInt(
      'patientId',
      this,
    );
    hospitalId = _i1.ColumnInt(
      'hospitalId',
      this,
    );
    dentistId = _i1.ColumnInt(
      'dentistId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    startTime = _i1.ColumnString(
      'startTime',
      this,
    );
    endTime = _i1.ColumnString(
      'endTime',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final AppointmentUpdateTable updateTable;

  late final _i1.ColumnInt patientId;

  _i2.PatientTable? _patient;

  late final _i1.ColumnInt hospitalId;

  _i3.HospitalTable? _hospital;

  late final _i1.ColumnInt dentistId;

  _i4.DentistTable? _dentist;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString startTime;

  late final _i1.ColumnString endTime;

  late final _i1.ColumnString reason;

  late final _i1.ColumnEnum<_i5.AppointmentStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.PatientTable get patient {
    if (_patient != null) return _patient!;
    _patient = _i1.createRelationTable(
      relationFieldName: 'patient',
      field: Appointment.t.patientId,
      foreignField: _i2.Patient.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PatientTable(tableRelation: foreignTableRelation),
    );
    return _patient!;
  }

  _i3.HospitalTable get hospital {
    if (_hospital != null) return _hospital!;
    _hospital = _i1.createRelationTable(
      relationFieldName: 'hospital',
      field: Appointment.t.hospitalId,
      foreignField: _i3.Hospital.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HospitalTable(tableRelation: foreignTableRelation),
    );
    return _hospital!;
  }

  _i4.DentistTable get dentist {
    if (_dentist != null) return _dentist!;
    _dentist = _i1.createRelationTable(
      relationFieldName: 'dentist',
      field: Appointment.t.dentistId,
      foreignField: _i4.Dentist.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.DentistTable(tableRelation: foreignTableRelation),
    );
    return _dentist!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    patientId,
    hospitalId,
    dentistId,
    date,
    startTime,
    endTime,
    reason,
    status,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'patient') {
      return patient;
    }
    if (relationField == 'hospital') {
      return hospital;
    }
    if (relationField == 'dentist') {
      return dentist;
    }
    return null;
  }
}

class AppointmentInclude extends _i1.IncludeObject {
  AppointmentInclude._({
    _i2.PatientInclude? patient,
    _i3.HospitalInclude? hospital,
    _i4.DentistInclude? dentist,
  }) {
    _patient = patient;
    _hospital = hospital;
    _dentist = dentist;
  }

  _i2.PatientInclude? _patient;

  _i3.HospitalInclude? _hospital;

  _i4.DentistInclude? _dentist;

  @override
  Map<String, _i1.Include?> get includes => {
    'patient': _patient,
    'hospital': _hospital,
    'dentist': _dentist,
  };

  @override
  _i1.Table<int?> get table => Appointment.t;
}

class AppointmentIncludeList extends _i1.IncludeList {
  AppointmentIncludeList._({
    _i1.WhereExpressionBuilder<AppointmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Appointment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Appointment.t;
}

class AppointmentRepository {
  const AppointmentRepository._();

  final attachRow = const AppointmentAttachRowRepository._();

  final detachRow = const AppointmentDetachRowRepository._();

  /// Returns a list of [Appointment]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Appointment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppointmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppointmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppointmentTable>? orderByList,
    _i1.Transaction? transaction,
    AppointmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Appointment>(
      where: where?.call(Appointment.t),
      orderBy: orderBy?.call(Appointment.t),
      orderByList: orderByList?.call(Appointment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Appointment] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Appointment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppointmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppointmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppointmentTable>? orderByList,
    _i1.Transaction? transaction,
    AppointmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Appointment>(
      where: where?.call(Appointment.t),
      orderBy: orderBy?.call(Appointment.t),
      orderByList: orderByList?.call(Appointment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Appointment] by its [id] or null if no such row exists.
  Future<Appointment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AppointmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Appointment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Appointment]s in the list and returns the inserted rows.
  ///
  /// The returned [Appointment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Appointment>> insert(
    _i1.DatabaseSession session,
    List<Appointment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Appointment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Appointment] and returns the inserted row.
  ///
  /// The returned [Appointment] will have its `id` field set.
  Future<Appointment> insertRow(
    _i1.DatabaseSession session,
    Appointment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Appointment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Appointment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Appointment>> update(
    _i1.DatabaseSession session,
    List<Appointment> rows, {
    _i1.ColumnSelections<AppointmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Appointment>(
      rows,
      columns: columns?.call(Appointment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Appointment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Appointment> updateRow(
    _i1.DatabaseSession session,
    Appointment row, {
    _i1.ColumnSelections<AppointmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Appointment>(
      row,
      columns: columns?.call(Appointment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Appointment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Appointment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AppointmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Appointment>(
      id,
      columnValues: columnValues(Appointment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Appointment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Appointment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AppointmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AppointmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppointmentTable>? orderBy,
    _i1.OrderByListBuilder<AppointmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Appointment>(
      columnValues: columnValues(Appointment.t.updateTable),
      where: where(Appointment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Appointment.t),
      orderByList: orderByList?.call(Appointment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Appointment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Appointment>> delete(
    _i1.DatabaseSession session,
    List<Appointment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Appointment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Appointment].
  Future<Appointment> deleteRow(
    _i1.DatabaseSession session,
    Appointment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Appointment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Appointment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppointmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Appointment>(
      where: where(Appointment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppointmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Appointment>(
      where: where?.call(Appointment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Appointment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppointmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Appointment>(
      where: where(Appointment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AppointmentAttachRowRepository {
  const AppointmentAttachRowRepository._();

  /// Creates a relation between the given [Appointment] and [Patient]
  /// by setting the [Appointment]'s foreign key `patientId` to refer to the [Patient].
  Future<void> patient(
    _i1.DatabaseSession session,
    Appointment appointment,
    _i2.Patient patient, {
    _i1.Transaction? transaction,
  }) async {
    if (appointment.id == null) {
      throw ArgumentError.notNull('appointment.id');
    }
    if (patient.id == null) {
      throw ArgumentError.notNull('patient.id');
    }

    var $appointment = appointment.copyWith(patientId: patient.id);
    await session.db.updateRow<Appointment>(
      $appointment,
      columns: [Appointment.t.patientId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Appointment] and [Hospital]
  /// by setting the [Appointment]'s foreign key `hospitalId` to refer to the [Hospital].
  Future<void> hospital(
    _i1.DatabaseSession session,
    Appointment appointment,
    _i3.Hospital hospital, {
    _i1.Transaction? transaction,
  }) async {
    if (appointment.id == null) {
      throw ArgumentError.notNull('appointment.id');
    }
    if (hospital.id == null) {
      throw ArgumentError.notNull('hospital.id');
    }

    var $appointment = appointment.copyWith(hospitalId: hospital.id);
    await session.db.updateRow<Appointment>(
      $appointment,
      columns: [Appointment.t.hospitalId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Appointment] and [Dentist]
  /// by setting the [Appointment]'s foreign key `dentistId` to refer to the [Dentist].
  Future<void> dentist(
    _i1.DatabaseSession session,
    Appointment appointment,
    _i4.Dentist dentist, {
    _i1.Transaction? transaction,
  }) async {
    if (appointment.id == null) {
      throw ArgumentError.notNull('appointment.id');
    }
    if (dentist.id == null) {
      throw ArgumentError.notNull('dentist.id');
    }

    var $appointment = appointment.copyWith(dentistId: dentist.id);
    await session.db.updateRow<Appointment>(
      $appointment,
      columns: [Appointment.t.dentistId],
      transaction: transaction,
    );
  }
}

class AppointmentDetachRowRepository {
  const AppointmentDetachRowRepository._();

  /// Detaches the relation between this [Appointment] and the [Dentist] set in `dentist`
  /// by setting the [Appointment]'s foreign key `dentistId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> dentist(
    _i1.DatabaseSession session,
    Appointment appointment, {
    _i1.Transaction? transaction,
  }) async {
    if (appointment.id == null) {
      throw ArgumentError.notNull('appointment.id');
    }

    var $appointment = appointment.copyWith(dentistId: null);
    await session.db.updateRow<Appointment>(
      $appointment,
      columns: [Appointment.t.dentistId],
      transaction: transaction,
    );
  }
}
