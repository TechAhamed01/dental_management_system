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

abstract class DentistDocument
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = DentistDocumentTable();

  static const db = DentistDocumentRepository._();

  @override
  int? id;

  int dentistId;

  _i2.Dentist? dentist;

  String documentType;

  String fileName;

  String mimeType;

  String storageKey;

  int fileSize;

  DateTime uploadedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DentistDocument',
      if (id != null) 'id': id,
      'dentistId': dentistId,
      if (dentist != null) 'dentist': dentist?.toJsonForProtocol(),
      'documentType': documentType,
      'fileName': fileName,
      'mimeType': mimeType,
      'storageKey': storageKey,
      'fileSize': fileSize,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  static DentistDocumentInclude include({_i2.DentistInclude? dentist}) {
    return DentistDocumentInclude._(dentist: dentist);
  }

  static DentistDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<DentistDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistDocumentTable>? orderByList,
    DentistDocumentInclude? include,
  }) {
    return DentistDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DentistDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DentistDocument.t),
      include: include,
    );
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

class DentistDocumentUpdateTable extends _i1.UpdateTable<DentistDocumentTable> {
  DentistDocumentUpdateTable(super.table);

  _i1.ColumnValue<int, int> dentistId(int value) => _i1.ColumnValue(
    table.dentistId,
    value,
  );

  _i1.ColumnValue<String, String> documentType(String value) => _i1.ColumnValue(
    table.documentType,
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

class DentistDocumentTable extends _i1.Table<int?> {
  DentistDocumentTable({super.tableRelation})
    : super(tableName: 'dentist_document') {
    updateTable = DentistDocumentUpdateTable(this);
    dentistId = _i1.ColumnInt(
      'dentistId',
      this,
    );
    documentType = _i1.ColumnString(
      'documentType',
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

  late final DentistDocumentUpdateTable updateTable;

  late final _i1.ColumnInt dentistId;

  _i2.DentistTable? _dentist;

  late final _i1.ColumnString documentType;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString mimeType;

  late final _i1.ColumnString storageKey;

  late final _i1.ColumnInt fileSize;

  late final _i1.ColumnDateTime uploadedAt;

  _i2.DentistTable get dentist {
    if (_dentist != null) return _dentist!;
    _dentist = _i1.createRelationTable(
      relationFieldName: 'dentist',
      field: DentistDocument.t.dentistId,
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
    documentType,
    fileName,
    mimeType,
    storageKey,
    fileSize,
    uploadedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'dentist') {
      return dentist;
    }
    return null;
  }
}

class DentistDocumentInclude extends _i1.IncludeObject {
  DentistDocumentInclude._({_i2.DentistInclude? dentist}) {
    _dentist = dentist;
  }

  _i2.DentistInclude? _dentist;

  @override
  Map<String, _i1.Include?> get includes => {'dentist': _dentist};

  @override
  _i1.Table<int?> get table => DentistDocument.t;
}

class DentistDocumentIncludeList extends _i1.IncludeList {
  DentistDocumentIncludeList._({
    _i1.WhereExpressionBuilder<DentistDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DentistDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DentistDocument.t;
}

class DentistDocumentRepository {
  const DentistDocumentRepository._();

  final attachRow = const DentistDocumentAttachRowRepository._();

  /// Returns a list of [DentistDocument]s matching the given query parameters.
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
  Future<List<DentistDocument>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    DentistDocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DentistDocument>(
      where: where?.call(DentistDocument.t),
      orderBy: orderBy?.call(DentistDocument.t),
      orderByList: orderByList?.call(DentistDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DentistDocument] matching the given query parameters.
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
  Future<DentistDocument?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<DentistDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    DentistDocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DentistDocument>(
      where: where?.call(DentistDocument.t),
      orderBy: orderBy?.call(DentistDocument.t),
      orderByList: orderByList?.call(DentistDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DentistDocument] by its [id] or null if no such row exists.
  Future<DentistDocument?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DentistDocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DentistDocument>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DentistDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [DentistDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DentistDocument>> insert(
    _i1.DatabaseSession session,
    List<DentistDocument> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DentistDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DentistDocument] and returns the inserted row.
  ///
  /// The returned [DentistDocument] will have its `id` field set.
  Future<DentistDocument> insertRow(
    _i1.DatabaseSession session,
    DentistDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DentistDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DentistDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DentistDocument>> update(
    _i1.DatabaseSession session,
    List<DentistDocument> rows, {
    _i1.ColumnSelections<DentistDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DentistDocument>(
      rows,
      columns: columns?.call(DentistDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DentistDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DentistDocument> updateRow(
    _i1.DatabaseSession session,
    DentistDocument row, {
    _i1.ColumnSelections<DentistDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DentistDocument>(
      row,
      columns: columns?.call(DentistDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DentistDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DentistDocument?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DentistDocumentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DentistDocument>(
      id,
      columnValues: columnValues(DentistDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DentistDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DentistDocument>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DentistDocumentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DentistDocumentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistDocumentTable>? orderBy,
    _i1.OrderByListBuilder<DentistDocumentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DentistDocument>(
      columnValues: columnValues(DentistDocument.t.updateTable),
      where: where(DentistDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DentistDocument.t),
      orderByList: orderByList?.call(DentistDocument.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DentistDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DentistDocument>> delete(
    _i1.DatabaseSession session,
    List<DentistDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DentistDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DentistDocument].
  Future<DentistDocument> deleteRow(
    _i1.DatabaseSession session,
    DentistDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DentistDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DentistDocument>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentistDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DentistDocument>(
      where: where(DentistDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DentistDocument>(
      where: where?.call(DentistDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DentistDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentistDocumentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DentistDocument>(
      where: where(DentistDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DentistDocumentAttachRowRepository {
  const DentistDocumentAttachRowRepository._();

  /// Creates a relation between the given [DentistDocument] and [Dentist]
  /// by setting the [DentistDocument]'s foreign key `dentistId` to refer to the [Dentist].
  Future<void> dentist(
    _i1.DatabaseSession session,
    DentistDocument dentistDocument,
    _i2.Dentist dentist, {
    _i1.Transaction? transaction,
  }) async {
    if (dentistDocument.id == null) {
      throw ArgumentError.notNull('dentistDocument.id');
    }
    if (dentist.id == null) {
      throw ArgumentError.notNull('dentist.id');
    }

    var $dentistDocument = dentistDocument.copyWith(dentistId: dentist.id);
    await session.db.updateRow<DentistDocument>(
      $dentistDocument,
      columns: [DentistDocument.t.dentistId],
      transaction: transaction,
    );
  }
}
