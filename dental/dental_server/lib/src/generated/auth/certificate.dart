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
import '../auth/dentist.dart' as _i2;
import 'package:dental_server/src/generated/protocol.dart' as _i3;

abstract class Certificate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CertificateTable();

  static const db = CertificateRepository._();

  @override
  int? id;

  int dentistId;

  _i2.Dentist? dentist;

  String fileUrl;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Certificate',
      if (id != null) 'id': id,
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJsonForProtocol(),
      'fileUrl': fileUrl,
    };
  }

  static CertificateInclude include({_i2.DentistInclude? dentist}) {
    return CertificateInclude._(dentist: dentist);
  }

  static CertificateIncludeList includeList({
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    CertificateInclude? include,
  }) {
    return CertificateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Certificate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Certificate.t),
      include: include,
    );
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

class CertificateUpdateTable extends _i1.UpdateTable<CertificateTable> {
  CertificateUpdateTable(super.table);

  _i1.ColumnValue<int, int> dentistId(int value) => _i1.ColumnValue(
    table.dentistId,
    value,
  );

  _i1.ColumnValue<String, String> fileUrl(String value) => _i1.ColumnValue(
    table.fileUrl,
    value,
  );
}

class CertificateTable extends _i1.Table<int?> {
  CertificateTable({super.tableRelation}) : super(tableName: 'certificate') {
    updateTable = CertificateUpdateTable(this);
    dentistId = _i1.ColumnInt(
      'dentistId',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
  }

  late final CertificateUpdateTable updateTable;

  late final _i1.ColumnInt dentistId;

  _i2.DentistTable? _dentist;

  late final _i1.ColumnString fileUrl;

  _i2.DentistTable get dentist {
    if (_dentist != null) return _dentist!;
    _dentist = _i1.createRelationTable(
      relationFieldName: 'dentist',
      field: Certificate.t.dentistId,
      foreignField: _i2.Dentist.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DentistTable(tableRelation: foreignTableRelation),
    );
    return _dentist!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    dentistId,
    fileUrl,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'dentist') {
      return dentist;
    }
    return null;
  }
}

class CertificateInclude extends _i1.IncludeObject {
  CertificateInclude._({_i2.DentistInclude? dentist}) {
    _dentist = dentist;
  }

  _i2.DentistInclude? _dentist;

  @override
  Map<String, _i1.Include?> get includes => {'dentist': _dentist};

  @override
  _i1.Table<int?> get table => Certificate.t;
}

class CertificateIncludeList extends _i1.IncludeList {
  CertificateIncludeList._({
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Certificate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Certificate.t;
}

class CertificateRepository {
  const CertificateRepository._();

  final attachRow = const CertificateAttachRowRepository._();

  /// Returns a list of [Certificate]s matching the given query parameters.
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
  Future<List<Certificate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Certificate>(
      where: where?.call(Certificate.t),
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Certificate] matching the given query parameters.
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
  Future<Certificate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Certificate>(
      where: where?.call(Certificate.t),
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Certificate] by its [id] or null if no such row exists.
  Future<Certificate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Certificate>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Certificate]s in the list and returns the inserted rows.
  ///
  /// The returned [Certificate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Certificate>> insert(
    _i1.DatabaseSession session,
    List<Certificate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Certificate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Certificate] and returns the inserted row.
  ///
  /// The returned [Certificate] will have its `id` field set.
  Future<Certificate> insertRow(
    _i1.DatabaseSession session,
    Certificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Certificate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Certificate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Certificate>> update(
    _i1.DatabaseSession session,
    List<Certificate> rows, {
    _i1.ColumnSelections<CertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Certificate>(
      rows,
      columns: columns?.call(Certificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Certificate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Certificate> updateRow(
    _i1.DatabaseSession session,
    Certificate row, {
    _i1.ColumnSelections<CertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Certificate>(
      row,
      columns: columns?.call(Certificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Certificate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Certificate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CertificateUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Certificate>(
      id,
      columnValues: columnValues(Certificate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Certificate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Certificate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CertificateUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Certificate>(
      columnValues: columnValues(Certificate.t.updateTable),
      where: where(Certificate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Certificate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Certificate>> delete(
    _i1.DatabaseSession session,
    List<Certificate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Certificate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Certificate].
  Future<Certificate> deleteRow(
    _i1.DatabaseSession session,
    Certificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Certificate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Certificate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Certificate>(
      where: where(Certificate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Certificate>(
      where: where?.call(Certificate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Certificate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Certificate>(
      where: where(Certificate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CertificateAttachRowRepository {
  const CertificateAttachRowRepository._();

  /// Creates a relation between the given [Certificate] and [Dentist]
  /// by setting the [Certificate]'s foreign key `dentistId` to refer to the [Dentist].
  Future<void> dentist(
    _i1.DatabaseSession session,
    Certificate certificate,
    _i2.Dentist dentist, {
    _i1.Transaction? transaction,
  }) async {
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }
    if (dentist.id == null) {
      throw ArgumentError.notNull('dentist.id');
    }

    var $certificate = certificate.copyWith(dentistId: dentist.id);
    await session.db.updateRow<Certificate>(
      $certificate,
      columns: [Certificate.t.dentistId],
      transaction: transaction,
    );
  }
}
