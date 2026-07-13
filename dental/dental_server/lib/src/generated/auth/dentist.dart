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
import '../auth/dentist_status.dart' as _i2;

abstract class Dentist
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Dentist._({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.passwordHash,
    required this.licenseNumber,
    required this.specialization,
    required this.experience,
    required this.clinicName,
    required this.clinicAddress,
    this.profilePhotoUrl,
    required this.isTermsAccepted,
    required this.status,
  });

  factory Dentist({
    int? id,
    required String fullName,
    required String email,
    required String phone,
    required String passwordHash,
    required String licenseNumber,
    required String specialization,
    required int experience,
    required String clinicName,
    required String clinicAddress,
    String? profilePhotoUrl,
    required bool isTermsAccepted,
    required _i2.DentistStatus status,
  }) = _DentistImpl;

  factory Dentist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dentist(
      id: jsonSerialization['id'] as int?,
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      phone: jsonSerialization['phone'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      licenseNumber: jsonSerialization['licenseNumber'] as String,
      specialization: jsonSerialization['specialization'] as String,
      experience: jsonSerialization['experience'] as int,
      clinicName: jsonSerialization['clinicName'] as String,
      clinicAddress: jsonSerialization['clinicAddress'] as String,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      isTermsAccepted: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isTermsAccepted'],
      ),
      status: _i2.DentistStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  static final t = DentistTable();

  static const db = DentistRepository._();

  @override
  int? id;

  String fullName;

  String email;

  String phone;

  String passwordHash;

  String licenseNumber;

  String specialization;

  int experience;

  String clinicName;

  String clinicAddress;

  String? profilePhotoUrl;

  bool isTermsAccepted;

  _i2.DentistStatus status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Dentist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dentist copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phone,
    String? passwordHash,
    String? licenseNumber,
    String? specialization,
    int? experience,
    String? clinicName,
    String? clinicAddress,
    String? profilePhotoUrl,
    bool? isTermsAccepted,
    _i2.DentistStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dentist',
      if (id != null) 'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'passwordHash': passwordHash,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      'isTermsAccepted': isTermsAccepted,
      'status': status.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Dentist',
      if (id != null) 'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'passwordHash': passwordHash,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      'isTermsAccepted': isTermsAccepted,
      'status': status.toJson(),
    };
  }

  static DentistInclude include() {
    return DentistInclude._();
  }

  static DentistIncludeList includeList({
    _i1.WhereExpressionBuilder<DentistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistTable>? orderByList,
    DentistInclude? include,
  }) {
    return DentistIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dentist.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Dentist.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DentistImpl extends Dentist {
  _DentistImpl({
    int? id,
    required String fullName,
    required String email,
    required String phone,
    required String passwordHash,
    required String licenseNumber,
    required String specialization,
    required int experience,
    required String clinicName,
    required String clinicAddress,
    String? profilePhotoUrl,
    required bool isTermsAccepted,
    required _i2.DentistStatus status,
  }) : super._(
         id: id,
         fullName: fullName,
         email: email,
         phone: phone,
         passwordHash: passwordHash,
         licenseNumber: licenseNumber,
         specialization: specialization,
         experience: experience,
         clinicName: clinicName,
         clinicAddress: clinicAddress,
         profilePhotoUrl: profilePhotoUrl,
         isTermsAccepted: isTermsAccepted,
         status: status,
       );

  /// Returns a shallow copy of this [Dentist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dentist copyWith({
    Object? id = _Undefined,
    String? fullName,
    String? email,
    String? phone,
    String? passwordHash,
    String? licenseNumber,
    String? specialization,
    int? experience,
    String? clinicName,
    String? clinicAddress,
    Object? profilePhotoUrl = _Undefined,
    bool? isTermsAccepted,
    _i2.DentistStatus? status,
  }) {
    return Dentist(
      id: id is int? ? id : this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      passwordHash: passwordHash ?? this.passwordHash,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      status: status ?? this.status,
    );
  }
}

class DentistUpdateTable extends _i1.UpdateTable<DentistTable> {
  DentistUpdateTable(super.table);

  _i1.ColumnValue<String, String> fullName(String value) => _i1.ColumnValue(
    table.fullName,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> passwordHash(String value) => _i1.ColumnValue(
    table.passwordHash,
    value,
  );

  _i1.ColumnValue<String, String> licenseNumber(String value) =>
      _i1.ColumnValue(
        table.licenseNumber,
        value,
      );

  _i1.ColumnValue<String, String> specialization(String value) =>
      _i1.ColumnValue(
        table.specialization,
        value,
      );

  _i1.ColumnValue<int, int> experience(int value) => _i1.ColumnValue(
    table.experience,
    value,
  );

  _i1.ColumnValue<String, String> clinicName(String value) => _i1.ColumnValue(
    table.clinicName,
    value,
  );

  _i1.ColumnValue<String, String> clinicAddress(String value) =>
      _i1.ColumnValue(
        table.clinicAddress,
        value,
      );

  _i1.ColumnValue<String, String> profilePhotoUrl(String? value) =>
      _i1.ColumnValue(
        table.profilePhotoUrl,
        value,
      );

  _i1.ColumnValue<bool, bool> isTermsAccepted(bool value) => _i1.ColumnValue(
    table.isTermsAccepted,
    value,
  );

  _i1.ColumnValue<_i2.DentistStatus, _i2.DentistStatus> status(
    _i2.DentistStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class DentistTable extends _i1.Table<int?> {
  DentistTable({super.tableRelation}) : super(tableName: 'dentist') {
    updateTable = DentistUpdateTable(this);
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
      this,
    );
    licenseNumber = _i1.ColumnString(
      'licenseNumber',
      this,
    );
    specialization = _i1.ColumnString(
      'specialization',
      this,
    );
    experience = _i1.ColumnInt(
      'experience',
      this,
    );
    clinicName = _i1.ColumnString(
      'clinicName',
      this,
    );
    clinicAddress = _i1.ColumnString(
      'clinicAddress',
      this,
    );
    profilePhotoUrl = _i1.ColumnString(
      'profilePhotoUrl',
      this,
    );
    isTermsAccepted = _i1.ColumnBool(
      'isTermsAccepted',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final DentistUpdateTable updateTable;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString email;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString passwordHash;

  late final _i1.ColumnString licenseNumber;

  late final _i1.ColumnString specialization;

  late final _i1.ColumnInt experience;

  late final _i1.ColumnString clinicName;

  late final _i1.ColumnString clinicAddress;

  late final _i1.ColumnString profilePhotoUrl;

  late final _i1.ColumnBool isTermsAccepted;

  late final _i1.ColumnEnum<_i2.DentistStatus> status;

  @override
  List<_i1.Column> get columns => [
    id,
    fullName,
    email,
    phone,
    passwordHash,
    licenseNumber,
    specialization,
    experience,
    clinicName,
    clinicAddress,
    profilePhotoUrl,
    isTermsAccepted,
    status,
  ];
}

class DentistInclude extends _i1.IncludeObject {
  DentistInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Dentist.t;
}

class DentistIncludeList extends _i1.IncludeList {
  DentistIncludeList._({
    _i1.WhereExpressionBuilder<DentistTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Dentist.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Dentist.t;
}

class DentistRepository {
  const DentistRepository._();

  /// Returns a list of [Dentist]s matching the given query parameters.
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
  Future<List<Dentist>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Dentist>(
      where: where?.call(Dentist.t),
      orderBy: orderBy?.call(Dentist.t),
      orderByList: orderByList?.call(Dentist.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Dentist] matching the given query parameters.
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
  Future<Dentist?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistTable>? where,
    int? offset,
    _i1.OrderByBuilder<DentistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DentistTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Dentist>(
      where: where?.call(Dentist.t),
      orderBy: orderBy?.call(Dentist.t),
      orderByList: orderByList?.call(Dentist.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Dentist] by its [id] or null if no such row exists.
  Future<Dentist?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Dentist>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Dentist]s in the list and returns the inserted rows.
  ///
  /// The returned [Dentist]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Dentist>> insert(
    _i1.DatabaseSession session,
    List<Dentist> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Dentist>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Dentist] and returns the inserted row.
  ///
  /// The returned [Dentist] will have its `id` field set.
  Future<Dentist> insertRow(
    _i1.DatabaseSession session,
    Dentist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Dentist>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Dentist]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Dentist>> update(
    _i1.DatabaseSession session,
    List<Dentist> rows, {
    _i1.ColumnSelections<DentistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Dentist>(
      rows,
      columns: columns?.call(Dentist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dentist]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Dentist> updateRow(
    _i1.DatabaseSession session,
    Dentist row, {
    _i1.ColumnSelections<DentistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Dentist>(
      row,
      columns: columns?.call(Dentist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dentist] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Dentist?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DentistUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Dentist>(
      id,
      columnValues: columnValues(Dentist.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Dentist]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Dentist>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DentistUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DentistTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DentistTable>? orderBy,
    _i1.OrderByListBuilder<DentistTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Dentist>(
      columnValues: columnValues(Dentist.t.updateTable),
      where: where(Dentist.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dentist.t),
      orderByList: orderByList?.call(Dentist.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Dentist]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Dentist>> delete(
    _i1.DatabaseSession session,
    List<Dentist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Dentist>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Dentist].
  Future<Dentist> deleteRow(
    _i1.DatabaseSession session,
    Dentist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Dentist>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Dentist>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentistTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Dentist>(
      where: where(Dentist.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DentistTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Dentist>(
      where: where?.call(Dentist.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Dentist] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DentistTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Dentist>(
      where: where(Dentist.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
