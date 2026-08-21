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

abstract class Hospital
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Hospital._({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.createdAt,
  });

  factory Hospital({
    int? id,
    required String name,
    required String address,
    required String phone,
    required String email,
    required bool isActive,
    required DateTime createdAt,
  }) = _HospitalImpl;

  factory Hospital.fromJson(Map<String, dynamic> jsonSerialization) {
    return Hospital(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      isActive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = HospitalTable();

  static const db = HospitalRepository._();

  @override
  int? id;

  String name;

  String address;

  String phone;

  String email;

  bool isActive;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Hospital copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Hospital',
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Hospital',
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static HospitalInclude include() {
    return HospitalInclude._();
  }

  static HospitalIncludeList includeList({
    _i1.WhereExpressionBuilder<HospitalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HospitalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HospitalTable>? orderByList,
    HospitalInclude? include,
  }) {
    return HospitalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Hospital.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Hospital.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HospitalImpl extends Hospital {
  _HospitalImpl({
    int? id,
    required String name,
    required String address,
    required String phone,
    required String email,
    required bool isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         address: address,
         phone: phone,
         email: email,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Hospital copyWith({
    Object? id = _Undefined,
    String? name,
    String? address,
    String? phone,
    String? email,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Hospital(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class HospitalUpdateTable extends _i1.UpdateTable<HospitalTable> {
  HospitalUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
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

class HospitalTable extends _i1.Table<int?> {
  HospitalTable({super.tableRelation}) : super(tableName: 'hospital') {
    updateTable = HospitalUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
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

  late final HospitalUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString address;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    address,
    phone,
    email,
    isActive,
    createdAt,
  ];
}

class HospitalInclude extends _i1.IncludeObject {
  HospitalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Hospital.t;
}

class HospitalIncludeList extends _i1.IncludeList {
  HospitalIncludeList._({
    _i1.WhereExpressionBuilder<HospitalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Hospital.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Hospital.t;
}

class HospitalRepository {
  const HospitalRepository._();

  /// Returns a list of [Hospital]s matching the given query parameters.
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
  Future<List<Hospital>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HospitalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HospitalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HospitalTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Hospital>(
      where: where?.call(Hospital.t),
      orderBy: orderBy?.call(Hospital.t),
      orderByList: orderByList?.call(Hospital.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Hospital] matching the given query parameters.
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
  Future<Hospital?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HospitalTable>? where,
    int? offset,
    _i1.OrderByBuilder<HospitalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HospitalTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Hospital>(
      where: where?.call(Hospital.t),
      orderBy: orderBy?.call(Hospital.t),
      orderByList: orderByList?.call(Hospital.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Hospital] by its [id] or null if no such row exists.
  Future<Hospital?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Hospital>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Hospital]s in the list and returns the inserted rows.
  ///
  /// The returned [Hospital]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Hospital>> insert(
    _i1.DatabaseSession session,
    List<Hospital> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Hospital>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Hospital] and returns the inserted row.
  ///
  /// The returned [Hospital] will have its `id` field set.
  Future<Hospital> insertRow(
    _i1.DatabaseSession session,
    Hospital row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Hospital>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Hospital]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Hospital>> update(
    _i1.DatabaseSession session,
    List<Hospital> rows, {
    _i1.ColumnSelections<HospitalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Hospital>(
      rows,
      columns: columns?.call(Hospital.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Hospital]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Hospital> updateRow(
    _i1.DatabaseSession session,
    Hospital row, {
    _i1.ColumnSelections<HospitalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Hospital>(
      row,
      columns: columns?.call(Hospital.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Hospital] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Hospital?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<HospitalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Hospital>(
      id,
      columnValues: columnValues(Hospital.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Hospital]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Hospital>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<HospitalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<HospitalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HospitalTable>? orderBy,
    _i1.OrderByListBuilder<HospitalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Hospital>(
      columnValues: columnValues(Hospital.t.updateTable),
      where: where(Hospital.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Hospital.t),
      orderByList: orderByList?.call(Hospital.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Hospital]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Hospital>> delete(
    _i1.DatabaseSession session,
    List<Hospital> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Hospital>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Hospital].
  Future<Hospital> deleteRow(
    _i1.DatabaseSession session,
    Hospital row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Hospital>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Hospital>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<HospitalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Hospital>(
      where: where(Hospital.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HospitalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Hospital>(
      where: where?.call(Hospital.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Hospital] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<HospitalTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Hospital>(
      where: where(Hospital.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
