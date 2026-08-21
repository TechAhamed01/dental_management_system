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
import '../hospital/hospital.dart' as _i2;
import 'package:dental_server/src/generated/protocol.dart' as _i3;

abstract class Receptionist
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Receptionist._({
    this.id,
    required this.hospitalId,
    this.hospital,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.phone,
    required this.isActive,
    required this.createdAt,
  });

  factory Receptionist({
    int? id,
    required int hospitalId,
    _i2.Hospital? hospital,
    required String fullName,
    required String email,
    required String passwordHash,
    required String phone,
    required bool isActive,
    required DateTime createdAt,
  }) = _ReceptionistImpl;

  factory Receptionist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Receptionist(
      id: jsonSerialization['id'] as int?,
      hospitalId: jsonSerialization['hospitalId'] as int,
      hospital: jsonSerialization['hospital'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Hospital>(
              jsonSerialization['hospital'],
            ),
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      phone: jsonSerialization['phone'] as String,
      isActive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ReceptionistTable();

  static const db = ReceptionistRepository._();

  @override
  int? id;

  int hospitalId;

  _i2.Hospital? hospital;

  String fullName;

  String email;

  String passwordHash;

  String phone;

  bool isActive;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Receptionist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Receptionist copyWith({
    int? id,
    int? hospitalId,
    _i2.Hospital? hospital,
    String? fullName,
    String? email,
    String? passwordHash,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Receptionist',
      if (id != null) 'id': id,
      'hospitalId': hospitalId,
      if (hospital != null) 'hospital': hospital?.toJson(),
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Receptionist',
      if (id != null) 'id': id,
      'hospitalId': hospitalId,
      if (hospital != null) 'hospital': hospital?.toJsonForProtocol(),
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static ReceptionistInclude include({_i2.HospitalInclude? hospital}) {
    return ReceptionistInclude._(hospital: hospital);
  }

  static ReceptionistIncludeList includeList({
    _i1.WhereExpressionBuilder<ReceptionistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReceptionistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReceptionistTable>? orderByList,
    ReceptionistInclude? include,
  }) {
    return ReceptionistIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Receptionist.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Receptionist.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReceptionistImpl extends Receptionist {
  _ReceptionistImpl({
    int? id,
    required int hospitalId,
    _i2.Hospital? hospital,
    required String fullName,
    required String email,
    required String passwordHash,
    required String phone,
    required bool isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         hospitalId: hospitalId,
         hospital: hospital,
         fullName: fullName,
         email: email,
         passwordHash: passwordHash,
         phone: phone,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Receptionist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Receptionist copyWith({
    Object? id = _Undefined,
    int? hospitalId,
    Object? hospital = _Undefined,
    String? fullName,
    String? email,
    String? passwordHash,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Receptionist(
      id: id is int? ? id : this.id,
      hospitalId: hospitalId ?? this.hospitalId,
      hospital: hospital is _i2.Hospital?
          ? hospital
          : this.hospital?.copyWith(),
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReceptionistUpdateTable extends _i1.UpdateTable<ReceptionistTable> {
  ReceptionistUpdateTable(super.table);

  _i1.ColumnValue<int, int> hospitalId(int value) => _i1.ColumnValue(
    table.hospitalId,
    value,
  );

  _i1.ColumnValue<String, String> fullName(String value) => _i1.ColumnValue(
    table.fullName,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> passwordHash(String value) => _i1.ColumnValue(
    table.passwordHash,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReceptionistTable extends _i1.Table<int?> {
  ReceptionistTable({super.tableRelation}) : super(tableName: 'receptionist') {
    updateTable = ReceptionistUpdateTable(this);
    hospitalId = _i1.ColumnInt(
      'hospitalId',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ReceptionistUpdateTable updateTable;

  late final _i1.ColumnInt hospitalId;

  _i2.HospitalTable? _hospital;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString email;

  late final _i1.ColumnString passwordHash;

  late final _i1.ColumnString phone;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  _i2.HospitalTable get hospital {
    if (_hospital != null) return _hospital!;
    _hospital = _i1.createRelationTable(
      relationFieldName: 'hospital',
      field: Receptionist.t.hospitalId,
      foreignField: _i2.Hospital.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HospitalTable(tableRelation: foreignTableRelation),
    );
    return _hospital!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    hospitalId,
    fullName,
    email,
    passwordHash,
    phone,
    isActive,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'hospital') {
      return hospital;
    }
    return null;
  }
}

class ReceptionistInclude extends _i1.IncludeObject {
  ReceptionistInclude._({_i2.HospitalInclude? hospital}) {
    _hospital = hospital;
  }

  _i2.HospitalInclude? _hospital;

  @override
  Map<String, _i1.Include?> get includes => {'hospital': _hospital};

  @override
  _i1.Table<int?> get table => Receptionist.t;
}

class ReceptionistIncludeList extends _i1.IncludeList {
  ReceptionistIncludeList._({
    _i1.WhereExpressionBuilder<ReceptionistTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Receptionist.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Receptionist.t;
}

class ReceptionistRepository {
  const ReceptionistRepository._();

  final attachRow = const ReceptionistAttachRowRepository._();

  /// Returns a list of [Receptionist]s matching the given query parameters.
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
  Future<List<Receptionist>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReceptionistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReceptionistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReceptionistTable>? orderByList,
    _i1.Transaction? transaction,
    ReceptionistInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Receptionist>(
      where: where?.call(Receptionist.t),
      orderBy: orderBy?.call(Receptionist.t),
      orderByList: orderByList?.call(Receptionist.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Receptionist] matching the given query parameters.
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
  Future<Receptionist?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReceptionistTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReceptionistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReceptionistTable>? orderByList,
    _i1.Transaction? transaction,
    ReceptionistInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Receptionist>(
      where: where?.call(Receptionist.t),
      orderBy: orderBy?.call(Receptionist.t),
      orderByList: orderByList?.call(Receptionist.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Receptionist] by its [id] or null if no such row exists.
  Future<Receptionist?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ReceptionistInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Receptionist>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Receptionist]s in the list and returns the inserted rows.
  ///
  /// The returned [Receptionist]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Receptionist>> insert(
    _i1.DatabaseSession session,
    List<Receptionist> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Receptionist>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Receptionist] and returns the inserted row.
  ///
  /// The returned [Receptionist] will have its `id` field set.
  Future<Receptionist> insertRow(
    _i1.DatabaseSession session,
    Receptionist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Receptionist>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Receptionist]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Receptionist>> update(
    _i1.DatabaseSession session,
    List<Receptionist> rows, {
    _i1.ColumnSelections<ReceptionistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Receptionist>(
      rows,
      columns: columns?.call(Receptionist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Receptionist]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Receptionist> updateRow(
    _i1.DatabaseSession session,
    Receptionist row, {
    _i1.ColumnSelections<ReceptionistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Receptionist>(
      row,
      columns: columns?.call(Receptionist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Receptionist] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Receptionist?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReceptionistUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Receptionist>(
      id,
      columnValues: columnValues(Receptionist.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Receptionist]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Receptionist>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReceptionistUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ReceptionistTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReceptionistTable>? orderBy,
    _i1.OrderByListBuilder<ReceptionistTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Receptionist>(
      columnValues: columnValues(Receptionist.t.updateTable),
      where: where(Receptionist.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Receptionist.t),
      orderByList: orderByList?.call(Receptionist.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Receptionist]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Receptionist>> delete(
    _i1.DatabaseSession session,
    List<Receptionist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Receptionist>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Receptionist].
  Future<Receptionist> deleteRow(
    _i1.DatabaseSession session,
    Receptionist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Receptionist>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Receptionist>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReceptionistTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Receptionist>(
      where: where(Receptionist.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReceptionistTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Receptionist>(
      where: where?.call(Receptionist.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Receptionist] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReceptionistTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Receptionist>(
      where: where(Receptionist.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ReceptionistAttachRowRepository {
  const ReceptionistAttachRowRepository._();

  /// Creates a relation between the given [Receptionist] and [Hospital]
  /// by setting the [Receptionist]'s foreign key `hospitalId` to refer to the [Hospital].
  Future<void> hospital(
    _i1.DatabaseSession session,
    Receptionist receptionist,
    _i2.Hospital hospital, {
    _i1.Transaction? transaction,
  }) async {
    if (receptionist.id == null) {
      throw ArgumentError.notNull('receptionist.id');
    }
    if (hospital.id == null) {
      throw ArgumentError.notNull('hospital.id');
    }

    var $receptionist = receptionist.copyWith(hospitalId: hospital.id);
    await session.db.updateRow<Receptionist>(
      $receptionist,
      columns: [Receptionist.t.hospitalId],
      transaction: transaction,
    );
  }
}
