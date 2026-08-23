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
import '../appointment/appointment.dart' as _i3;
import '../auth/dentist.dart' as _i4;
import 'package:dental_server/src/generated/protocol.dart' as _i5;

abstract class DentalImage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DentalImage._({
    this.id,
    required this.patientId,
    this.patient,
    required this.appointmentId,
    this.appointment,
    required this.dentistId,
    this.dentist,
    required this.fileName,
    required this.mimeType,
    required this.storageKey,
    required this.fileSize,
    required this.uploadedAt,
  });

  factory DentalImage({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int appointmentId,
    _i3.Appointment? appointment,
    required int dentistId,
    _i4.Dentist? dentist,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) = _DentalImageImpl;

  factory DentalImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DentalImage(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      patient: jsonSerialization['patient'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Patient>(
              jsonSerialization['patient'],
            ),
      appointmentId: jsonSerialization['appointmentId'] as int,
      appointment: jsonSerialization['appointment'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Appointment>(
              jsonSerialization['appointment'],
            ),
      dentistId: jsonSerialization['dentistId'] as int,
      dentist: jsonSerialization['dentist'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Dentist>(
              jsonSerialization['dentist'],
            ),
      fileName: jsonSerialization['fileName'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      fileSize: jsonSerialization['fileSize'] as int,
      uploadedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadedAt'],
      ),
    );
  }

  static final t = DentalImageTable();

  static const db = DentalImageRepository._();

  @override
  int? id;

  int patientId;

  _i2.Patient? patient;

  int appointmentId;

  _i3.Appointment? appointment;

  int dentistId;

  _i4.Dentist? dentist;

  String fileName;

  String mimeType;

  String storageKey;

  int fileSize;

  DateTime uploadedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DentalImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DentalImage copyWith({
    int? id,
    int? patientId,
    _i2.Patient? patient,
    int? appointmentId,
    _i3.Appointment? appointment,
    int? dentistId,
    _i4.Dentist? dentist,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DentalImage',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (patient != null) 'patient': patient?.toJson(),
      'appointmentId': appointmentId,
      if (appointment != null) 'appointment': appointment?.toJson(),
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJson(),
      'fileName': fileName,
      'mimeType': mimeType,
      'storageKey': storageKey,
      'fileSize': fileSize,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DentalImage',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (patient != null) 'patient': patient?.toJsonForProtocol(),
      'appointmentId': appointmentId,
      if (appointment != null) 'appointment': appointment?.toJsonForProtocol(),
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJsonForProtocol(),
      'fileName': fileName,
      'mimeType': mimeType,
      'storageKey': storageKey,
      'fileSize': fileSize,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  static DentalImageInclude include({
    _i2.PatientInclude? patient,
    _i3.AppointmentInclude? appointment,
    _i4.DentistInclude? dentist,
  }) {
    return DentalImageInclude._(
      patient: patient,
      appointment: appointment,
      dentist: dentist,
    );
  }

  static DentalImageIncludeList includeList({
    _i1.WhereExpressionBuilder<DentalImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentalImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentalImageTable>? orderByList,
    DentalImageInclude? include,
  }) {
    return DentalImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DentalImage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DentalImage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DentalImageImpl extends DentalImage {
  _DentalImageImpl({
    int? id,
    required int patientId,
    _i2.Patient? patient,
    required int appointmentId,
    _i3.Appointment? appointment,
    required int dentistId,
    _i4.Dentist? dentist,
    required String fileName,
    required String mimeType,
    required String storageKey,
    required int fileSize,
    required DateTime uploadedAt,
  }) : super._(
         id: id,
         patientId: patientId,
         patient: patient,
         appointmentId: appointmentId,
         appointment: appointment,
         dentistId: dentistId,
         dentist: dentist,
         fileName: fileName,
         mimeType: mimeType,
         storageKey: storageKey,
         fileSize: fileSize,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [DentalImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DentalImage copyWith({
    Object? id = _Undefined,
    int? patientId,
    Object? patient = _Undefined,
    int? appointmentId,
    Object? appointment = _Undefined,
    int? dentistId,
    Object? dentist = _Undefined,
    String? fileName,
    String? mimeType,
    String? storageKey,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return DentalImage(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      patient: patient is _i2.Patient? ? patient : this.patient?.copyWith(),
      appointmentId: appointmentId ?? this.appointmentId,
      appointment: appointment is _i3.Appointment?
          ? appointment
          : this.appointment?.copyWith(),
      dentistId: dentistId ?? this.dentistId,
      dentist: dentist is _i4.Dentist? ? dentist : this.dentist?.copyWith(),
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      storageKey: storageKey ?? this.storageKey,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}

class DentalImageUpdateTable extends _i1.UpdateTable<DentalImageTable> {
  DentalImageUpdateTable(super.table);

  _i1.ColumnValue<int, int> patientId(int value) => _i1.ColumnValue(
    table.patientId,
    value,
  );

  _i1.ColumnValue<int, int> appointmentId(int value) => _i1.ColumnValue(
    table.appointmentId,
    value,
  );

  _i1.ColumnValue<int, int> dentistId(int value) => _i1.ColumnValue(
    table.dentistId,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> mimeType(String value) => _i1.ColumnValue(
    table.mimeType,
    value,
  );

  _i1.ColumnValue<String, String> storageKey(String value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<int, int> fileSize(int value) => _i1.ColumnValue(
    table.fileSize,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> uploadedAt(DateTime value) =>
      _i1.ColumnValue(
        table.uploadedAt,
        value,
      );
}

class DentalImageTable extends _i1.Table<int?> {
  DentalImageTable({super.tableRelation}) : super(tableName: 'dental_image') {
    updateTable = DentalImageUpdateTable(this);
    patientId = _i1.ColumnInt(
      'patientId',
      this,
    );
    appointmentId = _i1.ColumnInt(
      'appointmentId',
      this,
    );
    dentistId = _i1.ColumnInt(
      'dentistId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    mimeType = _i1.ColumnString(
      'mimeType',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    fileSize = _i1.ColumnInt(
      'fileSize',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
  }

  late final DentalImageUpdateTable updateTable;

  late final _i1.ColumnInt patientId;

  _i2.PatientTable? _patient;

  late final _i1.ColumnInt appointmentId;

  _i3.AppointmentTable? _appointment;

  late final _i1.ColumnInt dentistId;

  _i4.DentistTable? _dentist;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString mimeType;

  late final _i1.ColumnString storageKey;

  late final _i1.ColumnInt fileSize;

  late final _i1.ColumnDateTime uploadedAt;

  _i2.PatientTable get patient {
    if (_patient != null) return _patient!;
    _patient = _i1.createRelationTable(
      relationFieldName: 'patient',
      field: DentalImage.t.patientId,
      foreignField: _i2.Patient.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PatientTable(tableRelation: foreignTableRelation),
    );
    return _patient!;
  }

  _i3.AppointmentTable get appointment {
    if (_appointment != null) return _appointment!;
    _appointment = _i1.createRelationTable(
      relationFieldName: 'appointment',
      field: DentalImage.t.appointmentId,
      foreignField: _i3.Appointment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppointmentTable(tableRelation: foreignTableRelation),
    );
    return _appointment!;
  }

  _i4.DentistTable get dentist {
    if (_dentist != null) return _dentist!;
    _dentist = _i1.createRelationTable(
      relationFieldName: 'dentist',
      field: DentalImage.t.dentistId,
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
    appointmentId,
    dentistId,
    fileName,
    mimeType,
    storageKey,
    fileSize,
    uploadedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'patient') {
      return patient;
    }
    if (relationField == 'appointment') {
      return appointment;
    }
    if (relationField == 'dentist') {
      return dentist;
    }
    return null;
  }
}

class DentalImageInclude extends _i1.IncludeObject {
  DentalImageInclude._({
    _i2.PatientInclude? patient,
    _i3.AppointmentInclude? appointment,
    _i4.DentistInclude? dentist,
  }) {
    _patient = patient;
    _appointment = appointment;
    _dentist = dentist;
  }

  _i2.PatientInclude? _patient;

  _i3.AppointmentInclude? _appointment;

  _i4.DentistInclude? _dentist;

  @override
  Map<String, _i1.Include?> get includes => {
    'patient': _patient,
    'appointment': _appointment,
    'dentist': _dentist,
  };

  @override
  _i1.Table<int?> get table => DentalImage.t;
}

class DentalImageIncludeList extends _i1.IncludeList {
  DentalImageIncludeList._({
    _i1.WhereExpressionBuilder<DentalImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DentalImage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DentalImage.t;
}

class DentalImageRepository {
  const DentalImageRepository._();

  final attachRow = const DentalImageAttachRowRepository._();

  /// Returns a list of [DentalImage]s matching the given query parameters.
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
  Future<List<DentalImage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentalImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentalImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentalImageTable>? orderByList,
    _i1.Transaction? transaction,
    DentalImageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DentalImage>(
      where: where?.call(DentalImage.t),
      orderBy: orderBy?.call(DentalImage.t),
      orderByList: orderByList?.call(DentalImage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DentalImage] matching the given query parameters.
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
  Future<DentalImage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentalImageTable>? where,
    int? offset,
    _i1.OrderByBuilder<DentalImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentalImageTable>? orderByList,
    _i1.Transaction? transaction,
    DentalImageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DentalImage>(
      where: where?.call(DentalImage.t),
      orderBy: orderBy?.call(DentalImage.t),
      orderByList: orderByList?.call(DentalImage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DentalImage] by its [id] or null if no such row exists.
  Future<DentalImage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DentalImageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DentalImage>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DentalImage]s in the list and returns the inserted rows.
  ///
  /// The returned [DentalImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DentalImage>> insert(
    _i1.DatabaseSession session,
    List<DentalImage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DentalImage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DentalImage] and returns the inserted row.
  ///
  /// The returned [DentalImage] will have its `id` field set.
  Future<DentalImage> insertRow(
    _i1.DatabaseSession session,
    DentalImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DentalImage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DentalImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DentalImage>> update(
    _i1.DatabaseSession session,
    List<DentalImage> rows, {
    _i1.ColumnSelections<DentalImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DentalImage>(
      rows,
      columns: columns?.call(DentalImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DentalImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DentalImage> updateRow(
    _i1.DatabaseSession session,
    DentalImage row, {
    _i1.ColumnSelections<DentalImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DentalImage>(
      row,
      columns: columns?.call(DentalImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DentalImage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DentalImage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DentalImageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DentalImage>(
      id,
      columnValues: columnValues(DentalImage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DentalImage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DentalImage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DentalImageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DentalImageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentalImageTable>? orderBy,
    _i1.OrderByListBuilder<DentalImageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DentalImage>(
      columnValues: columnValues(DentalImage.t.updateTable),
      where: where(DentalImage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DentalImage.t),
      orderByList: orderByList?.call(DentalImage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DentalImage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DentalImage>> delete(
    _i1.DatabaseSession session,
    List<DentalImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DentalImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DentalImage].
  Future<DentalImage> deleteRow(
    _i1.DatabaseSession session,
    DentalImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DentalImage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DentalImage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentalImageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DentalImage>(
      where: where(DentalImage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentalImageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DentalImage>(
      where: where?.call(DentalImage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DentalImage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentalImageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DentalImage>(
      where: where(DentalImage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DentalImageAttachRowRepository {
  const DentalImageAttachRowRepository._();

  /// Creates a relation between the given [DentalImage] and [Patient]
  /// by setting the [DentalImage]'s foreign key `patientId` to refer to the [Patient].
  Future<void> patient(
    _i1.DatabaseSession session,
    DentalImage dentalImage,
    _i2.Patient patient, {
    _i1.Transaction? transaction,
  }) async {
    if (dentalImage.id == null) {
      throw ArgumentError.notNull('dentalImage.id');
    }
    if (patient.id == null) {
      throw ArgumentError.notNull('patient.id');
    }

    var $dentalImage = dentalImage.copyWith(patientId: patient.id);
    await session.db.updateRow<DentalImage>(
      $dentalImage,
      columns: [DentalImage.t.patientId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [DentalImage] and [Appointment]
  /// by setting the [DentalImage]'s foreign key `appointmentId` to refer to the [Appointment].
  Future<void> appointment(
    _i1.DatabaseSession session,
    DentalImage dentalImage,
    _i3.Appointment appointment, {
    _i1.Transaction? transaction,
  }) async {
    if (dentalImage.id == null) {
      throw ArgumentError.notNull('dentalImage.id');
    }
    if (appointment.id == null) {
      throw ArgumentError.notNull('appointment.id');
    }

    var $dentalImage = dentalImage.copyWith(appointmentId: appointment.id);
    await session.db.updateRow<DentalImage>(
      $dentalImage,
      columns: [DentalImage.t.appointmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [DentalImage] and [Dentist]
  /// by setting the [DentalImage]'s foreign key `dentistId` to refer to the [Dentist].
  Future<void> dentist(
    _i1.DatabaseSession session,
    DentalImage dentalImage,
    _i4.Dentist dentist, {
    _i1.Transaction? transaction,
  }) async {
    if (dentalImage.id == null) {
      throw ArgumentError.notNull('dentalImage.id');
    }
    if (dentist.id == null) {
      throw ArgumentError.notNull('dentist.id');
    }

    var $dentalImage = dentalImage.copyWith(dentistId: dentist.id);
    await session.db.updateRow<DentalImage>(
      $dentalImage,
      columns: [DentalImage.t.dentistId],
      transaction: transaction,
    );
  }
}
