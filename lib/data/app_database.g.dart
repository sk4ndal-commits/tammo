// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HouseholdsTable extends Households
    with TableInfo<$HouseholdsTable, Household> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, householdId, name, createdBy, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'households';
  @override
  VerificationContext validateIntegrity(Insertable<Household> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Household map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Household(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HouseholdsTable createAlias(String alias) {
    return $HouseholdsTable(attachedDatabase, alias);
  }
}

class Household extends DataClass implements Insertable<Household> {
  final int id;
  final String householdId;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Household(
      {required this.id,
      required this.householdId,
      required this.name,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['household_id'] = Variable<String>(householdId);
    map['name'] = Variable<String>(name);
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HouseholdsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      name: Value(name),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Household.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Household(
      id: serializer.fromJson<int>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'householdId': serializer.toJson<String>(householdId),
      'name': serializer.toJson<String>(name),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Household copyWith(
          {int? id,
          String? householdId,
          String? name,
          String? createdBy,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Household(
        id: id ?? this.id,
        householdId: householdId ?? this.householdId,
        name: name ?? this.name,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Household copyWithCompanion(HouseholdsCompanion data) {
    return Household(
      id: data.id.present ? data.id.value : this.id,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Household(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, householdId, name, createdBy, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Household &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HouseholdsCompanion extends UpdateCompanion<Household> {
  final Value<int> id;
  final Value<String> householdId;
  final Value<String> name;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HouseholdsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HouseholdsCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    required String name,
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : householdId = Value(householdId),
        name = Value(name),
        createdBy = Value(createdBy);
  static Insertable<Household> custom({
    Expression<int>? id,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HouseholdsCompanion copyWith(
      {Value<int>? id,
      Value<String>? householdId,
      Value<String>? name,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return HouseholdsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HouseholdMembersTable extends HouseholdMembers
    with TableInfo<$HouseholdMembersTable, HouseholdMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _memberIdMeta =
      const VerificationMeta('memberId');
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
      'member_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _joinedAtMeta =
      const VerificationMeta('joinedAt');
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        memberId,
        householdId,
        userId,
        email,
        displayName,
        role,
        status,
        joinedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'household_members';
  @override
  VerificationContext validateIntegrity(Insertable<HouseholdMember> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('member_id')) {
      context.handle(_memberIdMeta,
          memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta));
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(_joinedAtMeta,
          joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HouseholdMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HouseholdMember(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      memberId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_id'])!,
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      joinedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joined_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HouseholdMembersTable createAlias(String alias) {
    return $HouseholdMembersTable(attachedDatabase, alias);
  }
}

class HouseholdMember extends DataClass implements Insertable<HouseholdMember> {
  final int id;
  final String memberId;
  final String householdId;
  final String userId;
  final String? email;
  final String? displayName;
  final String role;
  final String status;
  final DateTime joinedAt;
  final DateTime updatedAt;
  const HouseholdMember(
      {required this.id,
      required this.memberId,
      required this.householdId,
      required this.userId,
      this.email,
      this.displayName,
      required this.role,
      required this.status,
      required this.joinedAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member_id'] = Variable<String>(memberId);
    map['household_id'] = Variable<String>(householdId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HouseholdMembersCompanion toCompanion(bool nullToAbsent) {
    return HouseholdMembersCompanion(
      id: Value(id),
      memberId: Value(memberId),
      householdId: Value(householdId),
      userId: Value(userId),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      role: Value(role),
      status: Value(status),
      joinedAt: Value(joinedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HouseholdMember.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HouseholdMember(
      id: serializer.fromJson<int>(json['id']),
      memberId: serializer.fromJson<String>(json['memberId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      userId: serializer.fromJson<String>(json['userId']),
      email: serializer.fromJson<String?>(json['email']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memberId': serializer.toJson<String>(memberId),
      'householdId': serializer.toJson<String>(householdId),
      'userId': serializer.toJson<String>(userId),
      'email': serializer.toJson<String?>(email),
      'displayName': serializer.toJson<String?>(displayName),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HouseholdMember copyWith(
          {int? id,
          String? memberId,
          String? householdId,
          String? userId,
          Value<String?> email = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          String? role,
          String? status,
          DateTime? joinedAt,
          DateTime? updatedAt}) =>
      HouseholdMember(
        id: id ?? this.id,
        memberId: memberId ?? this.memberId,
        householdId: householdId ?? this.householdId,
        userId: userId ?? this.userId,
        email: email.present ? email.value : this.email,
        displayName: displayName.present ? displayName.value : this.displayName,
        role: role ?? this.role,
        status: status ?? this.status,
        joinedAt: joinedAt ?? this.joinedAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  HouseholdMember copyWithCompanion(HouseholdMembersCompanion data) {
    return HouseholdMember(
      id: data.id.present ? data.id.value : this.id,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      userId: data.userId.present ? data.userId.value : this.userId,
      email: data.email.present ? data.email.value : this.email,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdMember(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('householdId: $householdId, ')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, memberId, householdId, userId, email,
      displayName, role, status, joinedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HouseholdMember &&
          other.id == this.id &&
          other.memberId == this.memberId &&
          other.householdId == this.householdId &&
          other.userId == this.userId &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.role == this.role &&
          other.status == this.status &&
          other.joinedAt == this.joinedAt &&
          other.updatedAt == this.updatedAt);
}

class HouseholdMembersCompanion extends UpdateCompanion<HouseholdMember> {
  final Value<int> id;
  final Value<String> memberId;
  final Value<String> householdId;
  final Value<String> userId;
  final Value<String?> email;
  final Value<String?> displayName;
  final Value<String> role;
  final Value<String> status;
  final Value<DateTime> joinedAt;
  final Value<DateTime> updatedAt;
  const HouseholdMembersCompanion({
    this.id = const Value.absent(),
    this.memberId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HouseholdMembersCompanion.insert({
    this.id = const Value.absent(),
    required String memberId,
    required String householdId,
    required String userId,
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    required String role,
    required String status,
    this.joinedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : memberId = Value(memberId),
        householdId = Value(householdId),
        userId = Value(userId),
        role = Value(role),
        status = Value(status);
  static Insertable<HouseholdMember> custom({
    Expression<int>? id,
    Expression<String>? memberId,
    Expression<String>? householdId,
    Expression<String>? userId,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? role,
    Expression<String>? status,
    Expression<DateTime>? joinedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberId != null) 'member_id': memberId,
      if (householdId != null) 'household_id': householdId,
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HouseholdMembersCompanion copyWith(
      {Value<int>? id,
      Value<String>? memberId,
      Value<String>? householdId,
      Value<String>? userId,
      Value<String?>? email,
      Value<String?>? displayName,
      Value<String>? role,
      Value<String>? status,
      Value<DateTime>? joinedAt,
      Value<DateTime>? updatedAt}) {
    return HouseholdMembersCompanion(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      householdId: householdId ?? this.householdId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdMembersCompanion(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('householdId: $householdId, ')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HouseholdInvitationsTable extends HouseholdInvitations
    with TableInfo<$HouseholdInvitationsTable, HouseholdInvitation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdInvitationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _inviteIdMeta =
      const VerificationMeta('inviteId');
  @override
  late final GeneratedColumn<String> inviteId = GeneratedColumn<String>(
      'invite_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inviteTokenMeta =
      const VerificationMeta('inviteToken');
  @override
  late final GeneratedColumn<String> inviteToken = GeneratedColumn<String>(
      'invite_token', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        inviteId,
        householdId,
        inviteToken,
        email,
        role,
        status,
        message,
        createdBy,
        createdAt,
        expiresAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'household_invitations';
  @override
  VerificationContext validateIntegrity(
      Insertable<HouseholdInvitation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invite_id')) {
      context.handle(_inviteIdMeta,
          inviteId.isAcceptableOrUnknown(data['invite_id']!, _inviteIdMeta));
    } else if (isInserting) {
      context.missing(_inviteIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('invite_token')) {
      context.handle(
          _inviteTokenMeta,
          inviteToken.isAcceptableOrUnknown(
              data['invite_token']!, _inviteTokenMeta));
    } else if (isInserting) {
      context.missing(_inviteTokenMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HouseholdInvitation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HouseholdInvitation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      inviteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invite_id'])!,
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id'])!,
      inviteToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invite_token'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $HouseholdInvitationsTable createAlias(String alias) {
    return $HouseholdInvitationsTable(attachedDatabase, alias);
  }
}

class HouseholdInvitation extends DataClass
    implements Insertable<HouseholdInvitation> {
  final int id;
  final String inviteId;
  final String householdId;
  final String inviteToken;
  final String email;
  final String role;
  final String status;
  final String? message;
  final String createdBy;
  final DateTime createdAt;
  final DateTime expiresAt;
  const HouseholdInvitation(
      {required this.id,
      required this.inviteId,
      required this.householdId,
      required this.inviteToken,
      required this.email,
      required this.role,
      required this.status,
      this.message,
      required this.createdBy,
      required this.createdAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invite_id'] = Variable<String>(inviteId);
    map['household_id'] = Variable<String>(householdId);
    map['invite_token'] = Variable<String>(inviteToken);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  HouseholdInvitationsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdInvitationsCompanion(
      id: Value(id),
      inviteId: Value(inviteId),
      householdId: Value(householdId),
      inviteToken: Value(inviteToken),
      email: Value(email),
      role: Value(role),
      status: Value(status),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory HouseholdInvitation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HouseholdInvitation(
      id: serializer.fromJson<int>(json['id']),
      inviteId: serializer.fromJson<String>(json['inviteId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      inviteToken: serializer.fromJson<String>(json['inviteToken']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      message: serializer.fromJson<String?>(json['message']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inviteId': serializer.toJson<String>(inviteId),
      'householdId': serializer.toJson<String>(householdId),
      'inviteToken': serializer.toJson<String>(inviteToken),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'message': serializer.toJson<String?>(message),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  HouseholdInvitation copyWith(
          {int? id,
          String? inviteId,
          String? householdId,
          String? inviteToken,
          String? email,
          String? role,
          String? status,
          Value<String?> message = const Value.absent(),
          String? createdBy,
          DateTime? createdAt,
          DateTime? expiresAt}) =>
      HouseholdInvitation(
        id: id ?? this.id,
        inviteId: inviteId ?? this.inviteId,
        householdId: householdId ?? this.householdId,
        inviteToken: inviteToken ?? this.inviteToken,
        email: email ?? this.email,
        role: role ?? this.role,
        status: status ?? this.status,
        message: message.present ? message.value : this.message,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  HouseholdInvitation copyWithCompanion(HouseholdInvitationsCompanion data) {
    return HouseholdInvitation(
      id: data.id.present ? data.id.value : this.id,
      inviteId: data.inviteId.present ? data.inviteId.value : this.inviteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      inviteToken:
          data.inviteToken.present ? data.inviteToken.value : this.inviteToken,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      message: data.message.present ? data.message.value : this.message,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdInvitation(')
          ..write('id: $id, ')
          ..write('inviteId: $inviteId, ')
          ..write('householdId: $householdId, ')
          ..write('inviteToken: $inviteToken, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, inviteId, householdId, inviteToken, email,
      role, status, message, createdBy, createdAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HouseholdInvitation &&
          other.id == this.id &&
          other.inviteId == this.inviteId &&
          other.householdId == this.householdId &&
          other.inviteToken == this.inviteToken &&
          other.email == this.email &&
          other.role == this.role &&
          other.status == this.status &&
          other.message == this.message &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class HouseholdInvitationsCompanion
    extends UpdateCompanion<HouseholdInvitation> {
  final Value<int> id;
  final Value<String> inviteId;
  final Value<String> householdId;
  final Value<String> inviteToken;
  final Value<String> email;
  final Value<String> role;
  final Value<String> status;
  final Value<String?> message;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> expiresAt;
  const HouseholdInvitationsCompanion({
    this.id = const Value.absent(),
    this.inviteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.inviteToken = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.message = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
  });
  HouseholdInvitationsCompanion.insert({
    this.id = const Value.absent(),
    required String inviteId,
    required String householdId,
    required String inviteToken,
    required String email,
    required String role,
    required String status,
    this.message = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    required DateTime expiresAt,
  })  : inviteId = Value(inviteId),
        householdId = Value(householdId),
        inviteToken = Value(inviteToken),
        email = Value(email),
        role = Value(role),
        status = Value(status),
        createdBy = Value(createdBy),
        expiresAt = Value(expiresAt);
  static Insertable<HouseholdInvitation> custom({
    Expression<int>? id,
    Expression<String>? inviteId,
    Expression<String>? householdId,
    Expression<String>? inviteToken,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? status,
    Expression<String>? message,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inviteId != null) 'invite_id': inviteId,
      if (householdId != null) 'household_id': householdId,
      if (inviteToken != null) 'invite_token': inviteToken,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (message != null) 'message': message,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
    });
  }

  HouseholdInvitationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? inviteId,
      Value<String>? householdId,
      Value<String>? inviteToken,
      Value<String>? email,
      Value<String>? role,
      Value<String>? status,
      Value<String?>? message,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? expiresAt}) {
    return HouseholdInvitationsCompanion(
      id: id ?? this.id,
      inviteId: inviteId ?? this.inviteId,
      householdId: householdId ?? this.householdId,
      inviteToken: inviteToken ?? this.inviteToken,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inviteId.present) {
      map['invite_id'] = Variable<String>(inviteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (inviteToken.present) {
      map['invite_token'] = Variable<String>(inviteToken.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdInvitationsCompanion(')
          ..write('id: $id, ')
          ..write('inviteId: $inviteId, ')
          ..write('householdId: $householdId, ')
          ..write('inviteToken: $inviteToken, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }
}

class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _allergiesMeta =
      const VerificationMeta('allergies');
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
      'allergies', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        petId,
        householdId,
        name,
        species,
        dateOfBirth,
        gender,
        weight,
        photoPath,
        allergies,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(Insertable<Pet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('allergies')) {
      context.handle(_allergiesMeta,
          allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      allergies: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}allergies']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final int id;
  final String petId;
  final String? householdId;
  final String name;
  final String species;
  final DateTime? dateOfBirth;
  final String? gender;
  final double? weight;
  final String? photoPath;
  final String? allergies;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Pet(
      {required this.id,
      required this.petId,
      this.householdId,
      required this.name,
      required this.species,
      this.dateOfBirth,
      this.gender,
      this.weight,
      this.photoPath,
      this.allergies,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<String>(petId);
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    map['name'] = Variable<String>(name);
    map['species'] = Variable<String>(species);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      id: Value(id),
      petId: Value(petId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      name: Value(name),
      species: Value(species),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Pet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      species: serializer.fromJson<String>(json['species']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      gender: serializer.fromJson<String?>(json['gender']),
      weight: serializer.fromJson<double?>(json['weight']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<String>(petId),
      'householdId': serializer.toJson<String?>(householdId),
      'name': serializer.toJson<String>(name),
      'species': serializer.toJson<String>(species),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'weight': serializer.toJson<double?>(weight),
      'photoPath': serializer.toJson<String?>(photoPath),
      'allergies': serializer.toJson<String?>(allergies),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Pet copyWith(
          {int? id,
          String? petId,
          Value<String?> householdId = const Value.absent(),
          String? name,
          String? species,
          Value<DateTime?> dateOfBirth = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<String?> allergies = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Pet(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        householdId: householdId.present ? householdId.value : this.householdId,
        name: name ?? this.name,
        species: species ?? this.species,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        gender: gender.present ? gender.value : this.gender,
        weight: weight.present ? weight.value : this.weight,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        allergies: allergies.present ? allergies.value : this.allergies,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Pet copyWithCompanion(PetsCompanion data) {
    return Pet(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      species: data.species.present ? data.species.value : this.species,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      weight: data.weight.present ? data.weight.value : this.weight,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('photoPath: $photoPath, ')
          ..write('allergies: $allergies, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      petId,
      householdId,
      name,
      species,
      dateOfBirth,
      gender,
      weight,
      photoPath,
      allergies,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.species == this.species &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.weight == this.weight &&
          other.photoPath == this.photoPath &&
          other.allergies == this.allergies &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<int> id;
  final Value<String> petId;
  final Value<String?> householdId;
  final Value<String> name;
  final Value<String> species;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> gender;
  final Value<double?> weight;
  final Value<String?> photoPath;
  final Value<String?> allergies;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PetsCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.species = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.allergies = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PetsCompanion.insert({
    this.id = const Value.absent(),
    required String petId,
    this.householdId = const Value.absent(),
    required String name,
    required String species,
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.allergies = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : petId = Value(petId),
        name = Value(name),
        species = Value(species);
  static Insertable<Pet> custom({
    Expression<int>? id,
    Expression<String>? petId,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<String>? species,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? gender,
    Expression<double>? weight,
    Expression<String>? photoPath,
    Expression<String>? allergies,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (species != null) 'species': species,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (weight != null) 'weight': weight,
      if (photoPath != null) 'photo_path': photoPath,
      if (allergies != null) 'allergies': allergies,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? petId,
      Value<String?>? householdId,
      Value<String>? name,
      Value<String>? species,
      Value<DateTime?>? dateOfBirth,
      Value<String?>? gender,
      Value<double?>? weight,
      Value<String?>? photoPath,
      Value<String?>? allergies,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PetsCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      species: species ?? this.species,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      photoPath: photoPath ?? this.photoPath,
      allergies: allergies ?? this.allergies,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('photoPath: $photoPath, ')
          ..write('allergies: $allergies, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pets (pet_id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
      'frequency', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        petId,
        type,
        timestamp,
        frequency,
        notes,
        photoPath,
        createdBy,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String petId;
  final String type;
  final DateTime timestamp;
  final int frequency;
  final String? notes;
  final String? photoPath;
  final String? createdBy;
  final DateTime createdAt;
  const Event(
      {required this.id,
      required this.petId,
      required this.type,
      required this.timestamp,
      required this.frequency,
      this.notes,
      this.photoPath,
      this.createdBy,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<String>(petId);
    map['type'] = Variable<String>(type);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['frequency'] = Variable<int>(frequency);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      petId: Value(petId),
      type: Value(type),
      timestamp: Value(timestamp),
      frequency: Value(frequency),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdAt: Value(createdAt),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      type: serializer.fromJson<String>(json['type']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      frequency: serializer.fromJson<int>(json['frequency']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<String>(petId),
      'type': serializer.toJson<String>(type),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'frequency': serializer.toJson<int>(frequency),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdBy': serializer.toJson<String?>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Event copyWith(
          {int? id,
          String? petId,
          String? type,
          DateTime? timestamp,
          int? frequency,
          Value<String?> notes = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          DateTime? createdAt}) =>
      Event(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        type: type ?? this.type,
        timestamp: timestamp ?? this.timestamp,
        frequency: frequency ?? this.frequency,
        notes: notes.present ? notes.value : this.notes,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        createdAt: createdAt ?? this.createdAt,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('frequency: $frequency, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, type, timestamp, frequency, notes,
      photoPath, createdBy, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.frequency == this.frequency &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> petId;
  final Value<String> type;
  final Value<DateTime> timestamp;
  final Value<int> frequency;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<String?> createdBy;
  final Value<DateTime> createdAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.frequency = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String petId,
    required String type,
    this.timestamp = const Value.absent(),
    this.frequency = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : petId = Value(petId),
        type = Value(type);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? petId,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<int>? frequency,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (frequency != null) 'frequency': frequency,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? petId,
      Value<String>? type,
      Value<DateTime>? timestamp,
      Value<int>? frequency,
      Value<String?>? notes,
      Value<String?>? photoPath,
      Value<String?>? createdBy,
      Value<DateTime>? createdAt}) {
    return EventsCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      frequency: frequency ?? this.frequency,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('frequency: $frequency, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MedicationSchedulesTable extends MedicationSchedules
    with TableInfo<$MedicationSchedulesTable, MedicationSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pets (pet_id)'));
  static const VerificationMeta _medicationNameMeta =
      const VerificationMeta('medicationName');
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
      'medication_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _reminderTimesMeta =
      const VerificationMeta('reminderTimes');
  @override
  late final GeneratedColumn<String> reminderTimes = GeneratedColumn<String>(
      'reminder_times', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        petId,
        medicationName,
        dosage,
        frequency,
        startDate,
        endDate,
        reminderTimes,
        isActive,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_schedules';
  @override
  VerificationContext validateIntegrity(Insertable<MedicationSchedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('medication_name')) {
      context.handle(
          _medicationNameMeta,
          medicationName.isAcceptableOrUnknown(
              data['medication_name']!, _medicationNameMeta));
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('reminder_times')) {
      context.handle(
          _reminderTimesMeta,
          reminderTimes.isAcceptableOrUnknown(
              data['reminder_times']!, _reminderTimesMeta));
    } else if (isInserting) {
      context.missing(_reminderTimesMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationSchedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      medicationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}medication_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      reminderTimes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_times'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MedicationSchedulesTable createAlias(String alias) {
    return $MedicationSchedulesTable(attachedDatabase, alias);
  }
}

class MedicationSchedule extends DataClass
    implements Insertable<MedicationSchedule> {
  final int id;
  final String petId;
  final String medicationName;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final String reminderTimes;
  final bool isActive;
  final DateTime createdAt;
  const MedicationSchedule(
      {required this.id,
      required this.petId,
      required this.medicationName,
      required this.dosage,
      required this.frequency,
      required this.startDate,
      this.endDate,
      required this.reminderTimes,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<String>(petId);
    map['medication_name'] = Variable<String>(medicationName);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['reminder_times'] = Variable<String>(reminderTimes);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MedicationSchedulesCompanion toCompanion(bool nullToAbsent) {
    return MedicationSchedulesCompanion(
      id: Value(id),
      petId: Value(petId),
      medicationName: Value(medicationName),
      dosage: Value(dosage),
      frequency: Value(frequency),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      reminderTimes: Value(reminderTimes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory MedicationSchedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationSchedule(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      reminderTimes: serializer.fromJson<String>(json['reminderTimes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<String>(petId),
      'medicationName': serializer.toJson<String>(medicationName),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'reminderTimes': serializer.toJson<String>(reminderTimes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MedicationSchedule copyWith(
          {int? id,
          String? petId,
          String? medicationName,
          String? dosage,
          String? frequency,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          String? reminderTimes,
          bool? isActive,
          DateTime? createdAt}) =>
      MedicationSchedule(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        medicationName: medicationName ?? this.medicationName,
        dosage: dosage ?? this.dosage,
        frequency: frequency ?? this.frequency,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        reminderTimes: reminderTimes ?? this.reminderTimes,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  MedicationSchedule copyWithCompanion(MedicationSchedulesCompanion data) {
    return MedicationSchedule(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      medicationName: data.medicationName.present
          ? data.medicationName.value
          : this.medicationName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      reminderTimes: data.reminderTimes.present
          ? data.reminderTimes.value
          : this.reminderTimes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationSchedule(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reminderTimes: $reminderTimes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, medicationName, dosage, frequency,
      startDate, endDate, reminderTimes, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationSchedule &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.medicationName == this.medicationName &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.reminderTimes == this.reminderTimes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class MedicationSchedulesCompanion extends UpdateCompanion<MedicationSchedule> {
  final Value<int> id;
  final Value<String> petId;
  final Value<String> medicationName;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String> reminderTimes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const MedicationSchedulesCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.reminderTimes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MedicationSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String petId,
    required String medicationName,
    required String dosage,
    required String frequency,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required String reminderTimes,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : petId = Value(petId),
        medicationName = Value(medicationName),
        dosage = Value(dosage),
        frequency = Value(frequency),
        startDate = Value(startDate),
        reminderTimes = Value(reminderTimes);
  static Insertable<MedicationSchedule> custom({
    Expression<int>? id,
    Expression<String>? petId,
    Expression<String>? medicationName,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? reminderTimes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (medicationName != null) 'medication_name': medicationName,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (reminderTimes != null) 'reminder_times': reminderTimes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MedicationSchedulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? petId,
      Value<String>? medicationName,
      Value<String>? dosage,
      Value<String>? frequency,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<String>? reminderTimes,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return MedicationSchedulesCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (reminderTimes.present) {
      map['reminder_times'] = Variable<String>(reminderTimes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reminderTimes: $reminderTimes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MedicationCheckInsTable extends MedicationCheckIns
    with TableInfo<$MedicationCheckInsTable, MedicationCheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
      'schedule_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES medication_schedules (id)'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _plannedTimestampMeta =
      const VerificationMeta('plannedTimestamp');
  @override
  late final GeneratedColumn<DateTime> plannedTimestamp =
      GeneratedColumn<DateTime>('planned_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isTakenMeta =
      const VerificationMeta('isTaken');
  @override
  late final GeneratedColumn<bool> isTaken = GeneratedColumn<bool>(
      'is_taken', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_taken" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _completedByMeta =
      const VerificationMeta('completedBy');
  @override
  late final GeneratedColumn<String> completedBy = GeneratedColumn<String>(
      'completed_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completedByNameMeta =
      const VerificationMeta('completedByName');
  @override
  late final GeneratedColumn<String> completedByName = GeneratedColumn<String>(
      'completed_by_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scheduleId,
        timestamp,
        plannedTimestamp,
        isTaken,
        completedBy,
        completedByName,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_check_ins';
  @override
  VerificationContext validateIntegrity(Insertable<MedicationCheckIn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    } else if (isInserting) {
      context.missing(_scheduleIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('planned_timestamp')) {
      context.handle(
          _plannedTimestampMeta,
          plannedTimestamp.isAcceptableOrUnknown(
              data['planned_timestamp']!, _plannedTimestampMeta));
    } else if (isInserting) {
      context.missing(_plannedTimestampMeta);
    }
    if (data.containsKey('is_taken')) {
      context.handle(_isTakenMeta,
          isTaken.isAcceptableOrUnknown(data['is_taken']!, _isTakenMeta));
    }
    if (data.containsKey('completed_by')) {
      context.handle(
          _completedByMeta,
          completedBy.isAcceptableOrUnknown(
              data['completed_by']!, _completedByMeta));
    }
    if (data.containsKey('completed_by_name')) {
      context.handle(
          _completedByNameMeta,
          completedByName.isAcceptableOrUnknown(
              data['completed_by_name']!, _completedByNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationCheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationCheckIn(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schedule_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      plannedTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}planned_timestamp'])!,
      isTaken: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_taken'])!,
      completedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completed_by']),
      completedByName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}completed_by_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $MedicationCheckInsTable createAlias(String alias) {
    return $MedicationCheckInsTable(attachedDatabase, alias);
  }
}

class MedicationCheckIn extends DataClass
    implements Insertable<MedicationCheckIn> {
  final int id;
  final int scheduleId;
  final DateTime timestamp;
  final DateTime plannedTimestamp;
  final bool isTaken;
  final String? completedBy;
  final String? completedByName;
  final String? notes;
  const MedicationCheckIn(
      {required this.id,
      required this.scheduleId,
      required this.timestamp,
      required this.plannedTimestamp,
      required this.isTaken,
      this.completedBy,
      this.completedByName,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schedule_id'] = Variable<int>(scheduleId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['planned_timestamp'] = Variable<DateTime>(plannedTimestamp);
    map['is_taken'] = Variable<bool>(isTaken);
    if (!nullToAbsent || completedBy != null) {
      map['completed_by'] = Variable<String>(completedBy);
    }
    if (!nullToAbsent || completedByName != null) {
      map['completed_by_name'] = Variable<String>(completedByName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MedicationCheckInsCompanion toCompanion(bool nullToAbsent) {
    return MedicationCheckInsCompanion(
      id: Value(id),
      scheduleId: Value(scheduleId),
      timestamp: Value(timestamp),
      plannedTimestamp: Value(plannedTimestamp),
      isTaken: Value(isTaken),
      completedBy: completedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(completedBy),
      completedByName: completedByName == null && nullToAbsent
          ? const Value.absent()
          : Value(completedByName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory MedicationCheckIn.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationCheckIn(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<int>(json['scheduleId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      plannedTimestamp: serializer.fromJson<DateTime>(json['plannedTimestamp']),
      isTaken: serializer.fromJson<bool>(json['isTaken']),
      completedBy: serializer.fromJson<String?>(json['completedBy']),
      completedByName: serializer.fromJson<String?>(json['completedByName']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<int>(scheduleId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'plannedTimestamp': serializer.toJson<DateTime>(plannedTimestamp),
      'isTaken': serializer.toJson<bool>(isTaken),
      'completedBy': serializer.toJson<String?>(completedBy),
      'completedByName': serializer.toJson<String?>(completedByName),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MedicationCheckIn copyWith(
          {int? id,
          int? scheduleId,
          DateTime? timestamp,
          DateTime? plannedTimestamp,
          bool? isTaken,
          Value<String?> completedBy = const Value.absent(),
          Value<String?> completedByName = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      MedicationCheckIn(
        id: id ?? this.id,
        scheduleId: scheduleId ?? this.scheduleId,
        timestamp: timestamp ?? this.timestamp,
        plannedTimestamp: plannedTimestamp ?? this.plannedTimestamp,
        isTaken: isTaken ?? this.isTaken,
        completedBy: completedBy.present ? completedBy.value : this.completedBy,
        completedByName: completedByName.present
            ? completedByName.value
            : this.completedByName,
        notes: notes.present ? notes.value : this.notes,
      );
  MedicationCheckIn copyWithCompanion(MedicationCheckInsCompanion data) {
    return MedicationCheckIn(
      id: data.id.present ? data.id.value : this.id,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      plannedTimestamp: data.plannedTimestamp.present
          ? data.plannedTimestamp.value
          : this.plannedTimestamp,
      isTaken: data.isTaken.present ? data.isTaken.value : this.isTaken,
      completedBy:
          data.completedBy.present ? data.completedBy.value : this.completedBy,
      completedByName: data.completedByName.present
          ? data.completedByName.value
          : this.completedByName,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationCheckIn(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('plannedTimestamp: $plannedTimestamp, ')
          ..write('isTaken: $isTaken, ')
          ..write('completedBy: $completedBy, ')
          ..write('completedByName: $completedByName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scheduleId, timestamp, plannedTimestamp,
      isTaken, completedBy, completedByName, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationCheckIn &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.timestamp == this.timestamp &&
          other.plannedTimestamp == this.plannedTimestamp &&
          other.isTaken == this.isTaken &&
          other.completedBy == this.completedBy &&
          other.completedByName == this.completedByName &&
          other.notes == this.notes);
}

class MedicationCheckInsCompanion extends UpdateCompanion<MedicationCheckIn> {
  final Value<int> id;
  final Value<int> scheduleId;
  final Value<DateTime> timestamp;
  final Value<DateTime> plannedTimestamp;
  final Value<bool> isTaken;
  final Value<String?> completedBy;
  final Value<String?> completedByName;
  final Value<String?> notes;
  const MedicationCheckInsCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.plannedTimestamp = const Value.absent(),
    this.isTaken = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.completedByName = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MedicationCheckInsCompanion.insert({
    this.id = const Value.absent(),
    required int scheduleId,
    this.timestamp = const Value.absent(),
    required DateTime plannedTimestamp,
    this.isTaken = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.completedByName = const Value.absent(),
    this.notes = const Value.absent(),
  })  : scheduleId = Value(scheduleId),
        plannedTimestamp = Value(plannedTimestamp);
  static Insertable<MedicationCheckIn> custom({
    Expression<int>? id,
    Expression<int>? scheduleId,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? plannedTimestamp,
    Expression<bool>? isTaken,
    Expression<String>? completedBy,
    Expression<String>? completedByName,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (timestamp != null) 'timestamp': timestamp,
      if (plannedTimestamp != null) 'planned_timestamp': plannedTimestamp,
      if (isTaken != null) 'is_taken': isTaken,
      if (completedBy != null) 'completed_by': completedBy,
      if (completedByName != null) 'completed_by_name': completedByName,
      if (notes != null) 'notes': notes,
    });
  }

  MedicationCheckInsCompanion copyWith(
      {Value<int>? id,
      Value<int>? scheduleId,
      Value<DateTime>? timestamp,
      Value<DateTime>? plannedTimestamp,
      Value<bool>? isTaken,
      Value<String?>? completedBy,
      Value<String?>? completedByName,
      Value<String?>? notes}) {
    return MedicationCheckInsCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      timestamp: timestamp ?? this.timestamp,
      plannedTimestamp: plannedTimestamp ?? this.plannedTimestamp,
      isTaken: isTaken ?? this.isTaken,
      completedBy: completedBy ?? this.completedBy,
      completedByName: completedByName ?? this.completedByName,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (plannedTimestamp.present) {
      map['planned_timestamp'] = Variable<DateTime>(plannedTimestamp.value);
    }
    if (isTaken.present) {
      map['is_taken'] = Variable<bool>(isTaken.value);
    }
    if (completedBy.present) {
      map['completed_by'] = Variable<String>(completedBy.value);
    }
    if (completedByName.present) {
      map['completed_by_name'] = Variable<String>(completedByName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationCheckInsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('plannedTimestamp: $plannedTimestamp, ')
          ..write('isTaken: $isTaken, ')
          ..write('completedBy: $completedBy, ')
          ..write('completedByName: $completedByName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $FeedingSchedulesTable extends FeedingSchedules
    with TableInfo<$FeedingSchedulesTable, FeedingSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pets (pet_id)'));
  static const VerificationMeta _foodTypeMeta =
      const VerificationMeta('foodType');
  @override
  late final GeneratedColumn<String> foodType = GeneratedColumn<String>(
      'food_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<String> amount = GeneratedColumn<String>(
      'amount', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reminderTimesMeta =
      const VerificationMeta('reminderTimes');
  @override
  late final GeneratedColumn<String> reminderTimes = GeneratedColumn<String>(
      'reminder_times', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, petId, foodType, amount, reminderTimes, notes, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeding_schedules';
  @override
  VerificationContext validateIntegrity(Insertable<FeedingSchedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('food_type')) {
      context.handle(_foodTypeMeta,
          foodType.isAcceptableOrUnknown(data['food_type']!, _foodTypeMeta));
    } else if (isInserting) {
      context.missing(_foodTypeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reminder_times')) {
      context.handle(
          _reminderTimesMeta,
          reminderTimes.isAcceptableOrUnknown(
              data['reminder_times']!, _reminderTimesMeta));
    } else if (isInserting) {
      context.missing(_reminderTimesMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedingSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedingSchedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      foodType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}amount'])!,
      reminderTimes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_times'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FeedingSchedulesTable createAlias(String alias) {
    return $FeedingSchedulesTable(attachedDatabase, alias);
  }
}

class FeedingSchedule extends DataClass implements Insertable<FeedingSchedule> {
  final int id;
  final String petId;
  final String foodType;
  final String amount;
  final String reminderTimes;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  const FeedingSchedule(
      {required this.id,
      required this.petId,
      required this.foodType,
      required this.amount,
      required this.reminderTimes,
      this.notes,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<String>(petId);
    map['food_type'] = Variable<String>(foodType);
    map['amount'] = Variable<String>(amount);
    map['reminder_times'] = Variable<String>(reminderTimes);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FeedingSchedulesCompanion toCompanion(bool nullToAbsent) {
    return FeedingSchedulesCompanion(
      id: Value(id),
      petId: Value(petId),
      foodType: Value(foodType),
      amount: Value(amount),
      reminderTimes: Value(reminderTimes),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory FeedingSchedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedingSchedule(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      foodType: serializer.fromJson<String>(json['foodType']),
      amount: serializer.fromJson<String>(json['amount']),
      reminderTimes: serializer.fromJson<String>(json['reminderTimes']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<String>(petId),
      'foodType': serializer.toJson<String>(foodType),
      'amount': serializer.toJson<String>(amount),
      'reminderTimes': serializer.toJson<String>(reminderTimes),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FeedingSchedule copyWith(
          {int? id,
          String? petId,
          String? foodType,
          String? amount,
          String? reminderTimes,
          Value<String?> notes = const Value.absent(),
          bool? isActive,
          DateTime? createdAt}) =>
      FeedingSchedule(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        foodType: foodType ?? this.foodType,
        amount: amount ?? this.amount,
        reminderTimes: reminderTimes ?? this.reminderTimes,
        notes: notes.present ? notes.value : this.notes,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  FeedingSchedule copyWithCompanion(FeedingSchedulesCompanion data) {
    return FeedingSchedule(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      foodType: data.foodType.present ? data.foodType.value : this.foodType,
      amount: data.amount.present ? data.amount.value : this.amount,
      reminderTimes: data.reminderTimes.present
          ? data.reminderTimes.value
          : this.reminderTimes,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedingSchedule(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('foodType: $foodType, ')
          ..write('amount: $amount, ')
          ..write('reminderTimes: $reminderTimes, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, petId, foodType, amount, reminderTimes, notes, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedingSchedule &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.foodType == this.foodType &&
          other.amount == this.amount &&
          other.reminderTimes == this.reminderTimes &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class FeedingSchedulesCompanion extends UpdateCompanion<FeedingSchedule> {
  final Value<int> id;
  final Value<String> petId;
  final Value<String> foodType;
  final Value<String> amount;
  final Value<String> reminderTimes;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const FeedingSchedulesCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.foodType = const Value.absent(),
    this.amount = const Value.absent(),
    this.reminderTimes = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FeedingSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String petId,
    required String foodType,
    required String amount,
    required String reminderTimes,
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : petId = Value(petId),
        foodType = Value(foodType),
        amount = Value(amount),
        reminderTimes = Value(reminderTimes);
  static Insertable<FeedingSchedule> custom({
    Expression<int>? id,
    Expression<String>? petId,
    Expression<String>? foodType,
    Expression<String>? amount,
    Expression<String>? reminderTimes,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (foodType != null) 'food_type': foodType,
      if (amount != null) 'amount': amount,
      if (reminderTimes != null) 'reminder_times': reminderTimes,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FeedingSchedulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? petId,
      Value<String>? foodType,
      Value<String>? amount,
      Value<String>? reminderTimes,
      Value<String?>? notes,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return FeedingSchedulesCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      foodType: foodType ?? this.foodType,
      amount: amount ?? this.amount,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (foodType.present) {
      map['food_type'] = Variable<String>(foodType.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (reminderTimes.present) {
      map['reminder_times'] = Variable<String>(reminderTimes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('foodType: $foodType, ')
          ..write('amount: $amount, ')
          ..write('reminderTimes: $reminderTimes, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeedingCheckInsTable extends FeedingCheckIns
    with TableInfo<$FeedingCheckInsTable, FeedingCheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
      'schedule_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES feeding_schedules (id)'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _plannedTimestampMeta =
      const VerificationMeta('plannedTimestamp');
  @override
  late final GeneratedColumn<DateTime> plannedTimestamp =
      GeneratedColumn<DateTime>('planned_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedByMeta =
      const VerificationMeta('completedBy');
  @override
  late final GeneratedColumn<String> completedBy = GeneratedColumn<String>(
      'completed_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completedByNameMeta =
      const VerificationMeta('completedByName');
  @override
  late final GeneratedColumn<String> completedByName = GeneratedColumn<String>(
      'completed_by_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scheduleId,
        timestamp,
        plannedTimestamp,
        completedBy,
        completedByName,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeding_check_ins';
  @override
  VerificationContext validateIntegrity(Insertable<FeedingCheckIn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    } else if (isInserting) {
      context.missing(_scheduleIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('planned_timestamp')) {
      context.handle(
          _plannedTimestampMeta,
          plannedTimestamp.isAcceptableOrUnknown(
              data['planned_timestamp']!, _plannedTimestampMeta));
    } else if (isInserting) {
      context.missing(_plannedTimestampMeta);
    }
    if (data.containsKey('completed_by')) {
      context.handle(
          _completedByMeta,
          completedBy.isAcceptableOrUnknown(
              data['completed_by']!, _completedByMeta));
    }
    if (data.containsKey('completed_by_name')) {
      context.handle(
          _completedByNameMeta,
          completedByName.isAcceptableOrUnknown(
              data['completed_by_name']!, _completedByNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedingCheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedingCheckIn(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schedule_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      plannedTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}planned_timestamp'])!,
      completedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completed_by']),
      completedByName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}completed_by_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $FeedingCheckInsTable createAlias(String alias) {
    return $FeedingCheckInsTable(attachedDatabase, alias);
  }
}

class FeedingCheckIn extends DataClass implements Insertable<FeedingCheckIn> {
  final int id;
  final int scheduleId;
  final DateTime timestamp;
  final DateTime plannedTimestamp;
  final String? completedBy;
  final String? completedByName;
  final String? notes;
  const FeedingCheckIn(
      {required this.id,
      required this.scheduleId,
      required this.timestamp,
      required this.plannedTimestamp,
      this.completedBy,
      this.completedByName,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schedule_id'] = Variable<int>(scheduleId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['planned_timestamp'] = Variable<DateTime>(plannedTimestamp);
    if (!nullToAbsent || completedBy != null) {
      map['completed_by'] = Variable<String>(completedBy);
    }
    if (!nullToAbsent || completedByName != null) {
      map['completed_by_name'] = Variable<String>(completedByName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FeedingCheckInsCompanion toCompanion(bool nullToAbsent) {
    return FeedingCheckInsCompanion(
      id: Value(id),
      scheduleId: Value(scheduleId),
      timestamp: Value(timestamp),
      plannedTimestamp: Value(plannedTimestamp),
      completedBy: completedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(completedBy),
      completedByName: completedByName == null && nullToAbsent
          ? const Value.absent()
          : Value(completedByName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory FeedingCheckIn.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedingCheckIn(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<int>(json['scheduleId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      plannedTimestamp: serializer.fromJson<DateTime>(json['plannedTimestamp']),
      completedBy: serializer.fromJson<String?>(json['completedBy']),
      completedByName: serializer.fromJson<String?>(json['completedByName']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<int>(scheduleId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'plannedTimestamp': serializer.toJson<DateTime>(plannedTimestamp),
      'completedBy': serializer.toJson<String?>(completedBy),
      'completedByName': serializer.toJson<String?>(completedByName),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FeedingCheckIn copyWith(
          {int? id,
          int? scheduleId,
          DateTime? timestamp,
          DateTime? plannedTimestamp,
          Value<String?> completedBy = const Value.absent(),
          Value<String?> completedByName = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      FeedingCheckIn(
        id: id ?? this.id,
        scheduleId: scheduleId ?? this.scheduleId,
        timestamp: timestamp ?? this.timestamp,
        plannedTimestamp: plannedTimestamp ?? this.plannedTimestamp,
        completedBy: completedBy.present ? completedBy.value : this.completedBy,
        completedByName: completedByName.present
            ? completedByName.value
            : this.completedByName,
        notes: notes.present ? notes.value : this.notes,
      );
  FeedingCheckIn copyWithCompanion(FeedingCheckInsCompanion data) {
    return FeedingCheckIn(
      id: data.id.present ? data.id.value : this.id,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      plannedTimestamp: data.plannedTimestamp.present
          ? data.plannedTimestamp.value
          : this.plannedTimestamp,
      completedBy:
          data.completedBy.present ? data.completedBy.value : this.completedBy,
      completedByName: data.completedByName.present
          ? data.completedByName.value
          : this.completedByName,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedingCheckIn(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('plannedTimestamp: $plannedTimestamp, ')
          ..write('completedBy: $completedBy, ')
          ..write('completedByName: $completedByName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scheduleId, timestamp, plannedTimestamp,
      completedBy, completedByName, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedingCheckIn &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.timestamp == this.timestamp &&
          other.plannedTimestamp == this.plannedTimestamp &&
          other.completedBy == this.completedBy &&
          other.completedByName == this.completedByName &&
          other.notes == this.notes);
}

class FeedingCheckInsCompanion extends UpdateCompanion<FeedingCheckIn> {
  final Value<int> id;
  final Value<int> scheduleId;
  final Value<DateTime> timestamp;
  final Value<DateTime> plannedTimestamp;
  final Value<String?> completedBy;
  final Value<String?> completedByName;
  final Value<String?> notes;
  const FeedingCheckInsCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.plannedTimestamp = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.completedByName = const Value.absent(),
    this.notes = const Value.absent(),
  });
  FeedingCheckInsCompanion.insert({
    this.id = const Value.absent(),
    required int scheduleId,
    this.timestamp = const Value.absent(),
    required DateTime plannedTimestamp,
    this.completedBy = const Value.absent(),
    this.completedByName = const Value.absent(),
    this.notes = const Value.absent(),
  })  : scheduleId = Value(scheduleId),
        plannedTimestamp = Value(plannedTimestamp);
  static Insertable<FeedingCheckIn> custom({
    Expression<int>? id,
    Expression<int>? scheduleId,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? plannedTimestamp,
    Expression<String>? completedBy,
    Expression<String>? completedByName,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (timestamp != null) 'timestamp': timestamp,
      if (plannedTimestamp != null) 'planned_timestamp': plannedTimestamp,
      if (completedBy != null) 'completed_by': completedBy,
      if (completedByName != null) 'completed_by_name': completedByName,
      if (notes != null) 'notes': notes,
    });
  }

  FeedingCheckInsCompanion copyWith(
      {Value<int>? id,
      Value<int>? scheduleId,
      Value<DateTime>? timestamp,
      Value<DateTime>? plannedTimestamp,
      Value<String?>? completedBy,
      Value<String?>? completedByName,
      Value<String?>? notes}) {
    return FeedingCheckInsCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      timestamp: timestamp ?? this.timestamp,
      plannedTimestamp: plannedTimestamp ?? this.plannedTimestamp,
      completedBy: completedBy ?? this.completedBy,
      completedByName: completedByName ?? this.completedByName,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (plannedTimestamp.present) {
      map['planned_timestamp'] = Variable<DateTime>(plannedTimestamp.value);
    }
    if (completedBy.present) {
      map['completed_by'] = Variable<String>(completedBy.value);
    }
    if (completedByName.present) {
      map['completed_by_name'] = Variable<String>(completedByName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingCheckInsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('plannedTimestamp: $plannedTimestamp, ')
          ..write('completedBy: $completedBy, ')
          ..write('completedByName: $completedByName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pets (pet_id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, petId, name, type, date, filePath, tags, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<Document> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final String petId;
  final String name;
  final String type;
  final DateTime date;
  final String filePath;
  final String? tags;
  final String? notes;
  final DateTime createdAt;
  const Document(
      {required this.id,
      required this.petId,
      required this.name,
      required this.type,
      required this.date,
      required this.filePath,
      this.tags,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<String>(petId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      petId: Value(petId),
      name: Value(name),
      type: Value(type),
      date: Value(date),
      filePath: Value(filePath),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      filePath: serializer.fromJson<String>(json['filePath']),
      tags: serializer.fromJson<String?>(json['tags']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<String>(petId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'filePath': serializer.toJson<String>(filePath),
      'tags': serializer.toJson<String?>(tags),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Document copyWith(
          {int? id,
          String? petId,
          String? name,
          String? type,
          DateTime? date,
          String? filePath,
          Value<String?> tags = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Document(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        name: name ?? this.name,
        type: type ?? this.type,
        date: date ?? this.date,
        filePath: filePath ?? this.filePath,
        tags: tags.present ? tags.value : this.tags,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      tags: data.tags.present ? data.tags.value : this.tags,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('filePath: $filePath, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, petId, name, type, date, filePath, tags, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date &&
          other.filePath == this.filePath &&
          other.tags == this.tags &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> petId;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<String> filePath;
  final Value<String?> tags;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.filePath = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String petId,
    required String name,
    required String type,
    this.date = const Value.absent(),
    required String filePath,
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : petId = Value(petId),
        name = Value(name),
        type = Value(type),
        filePath = Value(filePath);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? petId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<String>? filePath,
    Expression<String>? tags,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (filePath != null) 'file_path': filePath,
      if (tags != null) 'tags': tags,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DocumentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? petId,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? date,
      Value<String>? filePath,
      Value<String?>? tags,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return DocumentsCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      filePath: filePath ?? this.filePath,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('filePath: $filePath, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HouseholdsTable households = $HouseholdsTable(this);
  late final $HouseholdMembersTable householdMembers =
      $HouseholdMembersTable(this);
  late final $HouseholdInvitationsTable householdInvitations =
      $HouseholdInvitationsTable(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $MedicationSchedulesTable medicationSchedules =
      $MedicationSchedulesTable(this);
  late final $MedicationCheckInsTable medicationCheckIns =
      $MedicationCheckInsTable(this);
  late final $FeedingSchedulesTable feedingSchedules =
      $FeedingSchedulesTable(this);
  late final $FeedingCheckInsTable feedingCheckIns =
      $FeedingCheckInsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        households,
        householdMembers,
        householdInvitations,
        pets,
        events,
        medicationSchedules,
        medicationCheckIns,
        feedingSchedules,
        feedingCheckIns,
        documents
      ];
}

typedef $$HouseholdsTableCreateCompanionBuilder = HouseholdsCompanion Function({
  Value<int> id,
  required String householdId,
  required String name,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$HouseholdsTableUpdateCompanionBuilder = HouseholdsCompanion Function({
  Value<int> id,
  Value<String> householdId,
  Value<String> name,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$HouseholdsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$HouseholdsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$HouseholdsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HouseholdsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HouseholdsTable,
    Household,
    $$HouseholdsTableFilterComposer,
    $$HouseholdsTableOrderingComposer,
    $$HouseholdsTableAnnotationComposer,
    $$HouseholdsTableCreateCompanionBuilder,
    $$HouseholdsTableUpdateCompanionBuilder,
    (Household, BaseReferences<_$AppDatabase, $HouseholdsTable, Household>),
    Household,
    PrefetchHooks Function()> {
  $$HouseholdsTableTableManager(_$AppDatabase db, $HouseholdsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> householdId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HouseholdsCompanion(
            id: id,
            householdId: householdId,
            name: name,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String householdId,
            required String name,
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HouseholdsCompanion.insert(
            id: id,
            householdId: householdId,
            name: name,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HouseholdsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HouseholdsTable,
    Household,
    $$HouseholdsTableFilterComposer,
    $$HouseholdsTableOrderingComposer,
    $$HouseholdsTableAnnotationComposer,
    $$HouseholdsTableCreateCompanionBuilder,
    $$HouseholdsTableUpdateCompanionBuilder,
    (Household, BaseReferences<_$AppDatabase, $HouseholdsTable, Household>),
    Household,
    PrefetchHooks Function()>;
typedef $$HouseholdMembersTableCreateCompanionBuilder
    = HouseholdMembersCompanion Function({
  Value<int> id,
  required String memberId,
  required String householdId,
  required String userId,
  Value<String?> email,
  Value<String?> displayName,
  required String role,
  required String status,
  Value<DateTime> joinedAt,
  Value<DateTime> updatedAt,
});
typedef $$HouseholdMembersTableUpdateCompanionBuilder
    = HouseholdMembersCompanion Function({
  Value<int> id,
  Value<String> memberId,
  Value<String> householdId,
  Value<String> userId,
  Value<String?> email,
  Value<String?> displayName,
  Value<String> role,
  Value<String> status,
  Value<DateTime> joinedAt,
  Value<DateTime> updatedAt,
});

class $$HouseholdMembersTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$HouseholdMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$HouseholdMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HouseholdMembersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HouseholdMembersTable,
    HouseholdMember,
    $$HouseholdMembersTableFilterComposer,
    $$HouseholdMembersTableOrderingComposer,
    $$HouseholdMembersTableAnnotationComposer,
    $$HouseholdMembersTableCreateCompanionBuilder,
    $$HouseholdMembersTableUpdateCompanionBuilder,
    (
      HouseholdMember,
      BaseReferences<_$AppDatabase, $HouseholdMembersTable, HouseholdMember>
    ),
    HouseholdMember,
    PrefetchHooks Function()> {
  $$HouseholdMembersTableTableManager(
      _$AppDatabase db, $HouseholdMembersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> memberId = const Value.absent(),
            Value<String> householdId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> joinedAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HouseholdMembersCompanion(
            id: id,
            memberId: memberId,
            householdId: householdId,
            userId: userId,
            email: email,
            displayName: displayName,
            role: role,
            status: status,
            joinedAt: joinedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String memberId,
            required String householdId,
            required String userId,
            Value<String?> email = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            required String role,
            required String status,
            Value<DateTime> joinedAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HouseholdMembersCompanion.insert(
            id: id,
            memberId: memberId,
            householdId: householdId,
            userId: userId,
            email: email,
            displayName: displayName,
            role: role,
            status: status,
            joinedAt: joinedAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HouseholdMembersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HouseholdMembersTable,
    HouseholdMember,
    $$HouseholdMembersTableFilterComposer,
    $$HouseholdMembersTableOrderingComposer,
    $$HouseholdMembersTableAnnotationComposer,
    $$HouseholdMembersTableCreateCompanionBuilder,
    $$HouseholdMembersTableUpdateCompanionBuilder,
    (
      HouseholdMember,
      BaseReferences<_$AppDatabase, $HouseholdMembersTable, HouseholdMember>
    ),
    HouseholdMember,
    PrefetchHooks Function()>;
typedef $$HouseholdInvitationsTableCreateCompanionBuilder
    = HouseholdInvitationsCompanion Function({
  Value<int> id,
  required String inviteId,
  required String householdId,
  required String inviteToken,
  required String email,
  required String role,
  required String status,
  Value<String?> message,
  required String createdBy,
  Value<DateTime> createdAt,
  required DateTime expiresAt,
});
typedef $$HouseholdInvitationsTableUpdateCompanionBuilder
    = HouseholdInvitationsCompanion Function({
  Value<int> id,
  Value<String> inviteId,
  Value<String> householdId,
  Value<String> inviteToken,
  Value<String> email,
  Value<String> role,
  Value<String> status,
  Value<String?> message,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime> expiresAt,
});

class $$HouseholdInvitationsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdInvitationsTable> {
  $$HouseholdInvitationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inviteId => $composableBuilder(
      column: $table.inviteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inviteToken => $composableBuilder(
      column: $table.inviteToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$HouseholdInvitationsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdInvitationsTable> {
  $$HouseholdInvitationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inviteId => $composableBuilder(
      column: $table.inviteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inviteToken => $composableBuilder(
      column: $table.inviteToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$HouseholdInvitationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdInvitationsTable> {
  $$HouseholdInvitationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inviteId =>
      $composableBuilder(column: $table.inviteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get inviteToken => $composableBuilder(
      column: $table.inviteToken, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$HouseholdInvitationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HouseholdInvitationsTable,
    HouseholdInvitation,
    $$HouseholdInvitationsTableFilterComposer,
    $$HouseholdInvitationsTableOrderingComposer,
    $$HouseholdInvitationsTableAnnotationComposer,
    $$HouseholdInvitationsTableCreateCompanionBuilder,
    $$HouseholdInvitationsTableUpdateCompanionBuilder,
    (
      HouseholdInvitation,
      BaseReferences<_$AppDatabase, $HouseholdInvitationsTable,
          HouseholdInvitation>
    ),
    HouseholdInvitation,
    PrefetchHooks Function()> {
  $$HouseholdInvitationsTableTableManager(
      _$AppDatabase db, $HouseholdInvitationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdInvitationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdInvitationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdInvitationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> inviteId = const Value.absent(),
            Value<String> householdId = const Value.absent(),
            Value<String> inviteToken = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> message = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
          }) =>
              HouseholdInvitationsCompanion(
            id: id,
            inviteId: inviteId,
            householdId: householdId,
            inviteToken: inviteToken,
            email: email,
            role: role,
            status: status,
            message: message,
            createdBy: createdBy,
            createdAt: createdAt,
            expiresAt: expiresAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String inviteId,
            required String householdId,
            required String inviteToken,
            required String email,
            required String role,
            required String status,
            Value<String?> message = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            required DateTime expiresAt,
          }) =>
              HouseholdInvitationsCompanion.insert(
            id: id,
            inviteId: inviteId,
            householdId: householdId,
            inviteToken: inviteToken,
            email: email,
            role: role,
            status: status,
            message: message,
            createdBy: createdBy,
            createdAt: createdAt,
            expiresAt: expiresAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HouseholdInvitationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $HouseholdInvitationsTable,
        HouseholdInvitation,
        $$HouseholdInvitationsTableFilterComposer,
        $$HouseholdInvitationsTableOrderingComposer,
        $$HouseholdInvitationsTableAnnotationComposer,
        $$HouseholdInvitationsTableCreateCompanionBuilder,
        $$HouseholdInvitationsTableUpdateCompanionBuilder,
        (
          HouseholdInvitation,
          BaseReferences<_$AppDatabase, $HouseholdInvitationsTable,
              HouseholdInvitation>
        ),
        HouseholdInvitation,
        PrefetchHooks Function()>;
typedef $$PetsTableCreateCompanionBuilder = PetsCompanion Function({
  Value<int> id,
  required String petId,
  Value<String?> householdId,
  required String name,
  required String species,
  Value<DateTime?> dateOfBirth,
  Value<String?> gender,
  Value<double?> weight,
  Value<String?> photoPath,
  Value<String?> allergies,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PetsTableUpdateCompanionBuilder = PetsCompanion Function({
  Value<int> id,
  Value<String> petId,
  Value<String?> householdId,
  Value<String> name,
  Value<String> species,
  Value<DateTime?> dateOfBirth,
  Value<String?> gender,
  Value<double?> weight,
  Value<String?> photoPath,
  Value<String?> allergies,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PetsTableReferences
    extends BaseReferences<_$AppDatabase, $PetsTable, Pet> {
  $$PetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.events,
          aliasName: $_aliasNameGenerator(db.pets.petId, db.events.petId));

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events).filter(
        (f) => f.petId.petId.sqlEquals($_itemColumn<String>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicationSchedulesTable,
      List<MedicationSchedule>> _medicationSchedulesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.medicationSchedules,
          aliasName: $_aliasNameGenerator(
              db.pets.petId, db.medicationSchedules.petId));

  $$MedicationSchedulesTableProcessedTableManager get medicationSchedulesRefs {
    final manager = $$MedicationSchedulesTableTableManager(
            $_db, $_db.medicationSchedules)
        .filter(
            (f) => f.petId.petId.sqlEquals($_itemColumn<String>('pet_id')!));

    final cache =
        $_typedResult.readTableOrNull(_medicationSchedulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeedingSchedulesTable, List<FeedingSchedule>>
      _feedingSchedulesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.feedingSchedules,
              aliasName: $_aliasNameGenerator(
                  db.pets.petId, db.feedingSchedules.petId));

  $$FeedingSchedulesTableProcessedTableManager get feedingSchedulesRefs {
    final manager =
        $$FeedingSchedulesTableTableManager($_db, $_db.feedingSchedules).filter(
            (f) => f.petId.petId.sqlEquals($_itemColumn<String>('pet_id')!));

    final cache =
        $_typedResult.readTableOrNull(_feedingSchedulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
      _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.documents,
          aliasName: $_aliasNameGenerator(db.pets.petId, db.documents.petId));

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager($_db, $_db.documents).filter(
        (f) => f.petId.petId.sqlEquals($_itemColumn<String>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PetsTableFilterComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get allergies => $composableBuilder(
      column: $table.allergies, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> eventsRefs(
      Expression<bool> Function($$EventsTableFilterComposer f) f) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> medicationSchedulesRefs(
      Expression<bool> Function($$MedicationSchedulesTableFilterComposer f) f) {
    final $$MedicationSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.medicationSchedules,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.medicationSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feedingSchedulesRefs(
      Expression<bool> Function($$FeedingSchedulesTableFilterComposer f) f) {
    final $$FeedingSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.feedingSchedules,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.feedingSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> documentsRefs(
      Expression<bool> Function($$DocumentsTableFilterComposer f) f) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.documents,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentsTableFilterComposer(
              $db: $db,
              $table: $db.documents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PetsTableOrderingComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get allergies => $composableBuilder(
      column: $table.allergies, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
      Expression<T> Function($$EventsTableAnnotationComposer a) f) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> medicationSchedulesRefs<T extends Object>(
      Expression<T> Function($$MedicationSchedulesTableAnnotationComposer a)
          f) {
    final $$MedicationSchedulesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.petId,
            referencedTable: $db.medicationSchedules,
            getReferencedColumn: (t) => t.petId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicationSchedulesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicationSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> feedingSchedulesRefs<T extends Object>(
      Expression<T> Function($$FeedingSchedulesTableAnnotationComposer a) f) {
    final $$FeedingSchedulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.feedingSchedules,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingSchedulesTableAnnotationComposer(
              $db: $db,
              $table: $db.feedingSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
      Expression<T> Function($$DocumentsTableAnnotationComposer a) f) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.documents,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentsTableAnnotationComposer(
              $db: $db,
              $table: $db.documents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PetsTable,
    Pet,
    $$PetsTableFilterComposer,
    $$PetsTableOrderingComposer,
    $$PetsTableAnnotationComposer,
    $$PetsTableCreateCompanionBuilder,
    $$PetsTableUpdateCompanionBuilder,
    (Pet, $$PetsTableReferences),
    Pet,
    PrefetchHooks Function(
        {bool eventsRefs,
        bool medicationSchedulesRefs,
        bool feedingSchedulesRefs,
        bool documentsRefs})> {
  $$PetsTableTableManager(_$AppDatabase db, $PetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> species = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> allergies = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PetsCompanion(
            id: id,
            petId: petId,
            householdId: householdId,
            name: name,
            species: species,
            dateOfBirth: dateOfBirth,
            gender: gender,
            weight: weight,
            photoPath: photoPath,
            allergies: allergies,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String petId,
            Value<String?> householdId = const Value.absent(),
            required String name,
            required String species,
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> allergies = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PetsCompanion.insert(
            id: id,
            petId: petId,
            householdId: householdId,
            name: name,
            species: species,
            dateOfBirth: dateOfBirth,
            gender: gender,
            weight: weight,
            photoPath: photoPath,
            allergies: allergies,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PetsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {eventsRefs = false,
              medicationSchedulesRefs = false,
              feedingSchedulesRefs = false,
              documentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventsRefs) db.events,
                if (medicationSchedulesRefs) db.medicationSchedules,
                if (feedingSchedulesRefs) db.feedingSchedules,
                if (documentsRefs) db.documents
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsRefs)
                    await $_getPrefetchedData<Pet, $PetsTable, Event>(
                        currentTable: table,
                        referencedTable:
                            $$PetsTableReferences._eventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PetsTableReferences(db, table, p0).eventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.petId == item.petId),
                        typedResults: items),
                  if (medicationSchedulesRefs)
                    await $_getPrefetchedData<Pet, $PetsTable,
                            MedicationSchedule>(
                        currentTable: table,
                        referencedTable: $$PetsTableReferences
                            ._medicationSchedulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PetsTableReferences(db, table, p0)
                                .medicationSchedulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.petId == item.petId),
                        typedResults: items),
                  if (feedingSchedulesRefs)
                    await $_getPrefetchedData<Pet, $PetsTable, FeedingSchedule>(
                        currentTable: table,
                        referencedTable: $$PetsTableReferences
                            ._feedingSchedulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PetsTableReferences(db, table, p0)
                                .feedingSchedulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.petId == item.petId),
                        typedResults: items),
                  if (documentsRefs)
                    await $_getPrefetchedData<Pet, $PetsTable, Document>(
                        currentTable: table,
                        referencedTable:
                            $$PetsTableReferences._documentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PetsTableReferences(db, table, p0).documentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.petId == item.petId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PetsTable,
    Pet,
    $$PetsTableFilterComposer,
    $$PetsTableOrderingComposer,
    $$PetsTableAnnotationComposer,
    $$PetsTableCreateCompanionBuilder,
    $$PetsTableUpdateCompanionBuilder,
    (Pet, $$PetsTableReferences),
    Pet,
    PrefetchHooks Function(
        {bool eventsRefs,
        bool medicationSchedulesRefs,
        bool feedingSchedulesRefs,
        bool documentsRefs})>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  required String petId,
  required String type,
  Value<DateTime> timestamp,
  Value<int> frequency,
  Value<String?> notes,
  Value<String?> photoPath,
  Value<String?> createdBy,
  Value<DateTime> createdAt,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<String> petId,
  Value<String> type,
  Value<DateTime> timestamp,
  Value<int> frequency,
  Value<String?> notes,
  Value<String?> photoPath,
  Value<String?> createdBy,
  Value<DateTime> createdAt,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDatabase db) =>
      db.pets.createAlias($_aliasNameGenerator(db.events.petId, db.pets.petId));

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<String>('pet_id')!;

    final manager = $$PetsTableTableManager($_db, $_db.pets)
        .filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableFilterComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableOrderingComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableAnnotationComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function({bool petId})> {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> frequency = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            petId: petId,
            type: type,
            timestamp: timestamp,
            frequency: frequency,
            notes: notes,
            photoPath: photoPath,
            createdBy: createdBy,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String petId,
            required String type,
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> frequency = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            petId: petId,
            type: type,
            timestamp: timestamp,
            frequency: frequency,
            notes: notes,
            photoPath: photoPath,
            createdBy: createdBy,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EventsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (petId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.petId,
                    referencedTable: $$EventsTableReferences._petIdTable(db),
                    referencedColumn:
                        $$EventsTableReferences._petIdTable(db).petId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function({bool petId})>;
typedef $$MedicationSchedulesTableCreateCompanionBuilder
    = MedicationSchedulesCompanion Function({
  Value<int> id,
  required String petId,
  required String medicationName,
  required String dosage,
  required String frequency,
  required DateTime startDate,
  Value<DateTime?> endDate,
  required String reminderTimes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$MedicationSchedulesTableUpdateCompanionBuilder
    = MedicationSchedulesCompanion Function({
  Value<int> id,
  Value<String> petId,
  Value<String> medicationName,
  Value<String> dosage,
  Value<String> frequency,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<String> reminderTimes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$MedicationSchedulesTableReferences extends BaseReferences<
    _$AppDatabase, $MedicationSchedulesTable, MedicationSchedule> {
  $$MedicationSchedulesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDatabase db) => db.pets.createAlias(
      $_aliasNameGenerator(db.medicationSchedules.petId, db.pets.petId));

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<String>('pet_id')!;

    final manager = $$PetsTableTableManager($_db, $_db.pets)
        .filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MedicationCheckInsTable, List<MedicationCheckIn>>
      _medicationCheckInsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.medicationCheckIns,
              aliasName: $_aliasNameGenerator(
                  db.medicationSchedules.id, db.medicationCheckIns.scheduleId));

  $$MedicationCheckInsTableProcessedTableManager get medicationCheckInsRefs {
    final manager =
        $$MedicationCheckInsTableTableManager($_db, $_db.medicationCheckIns)
            .filter((f) => f.scheduleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_medicationCheckInsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MedicationSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicationName => $composableBuilder(
      column: $table.medicationName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableFilterComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> medicationCheckInsRefs(
      Expression<bool> Function($$MedicationCheckInsTableFilterComposer f) f) {
    final $$MedicationCheckInsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicationCheckIns,
        getReferencedColumn: (t) => t.scheduleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationCheckInsTableFilterComposer(
              $db: $db,
              $table: $db.medicationCheckIns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MedicationSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicationName => $composableBuilder(
      column: $table.medicationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableOrderingComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicationName => $composableBuilder(
      column: $table.medicationName, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableAnnotationComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> medicationCheckInsRefs<T extends Object>(
      Expression<T> Function($$MedicationCheckInsTableAnnotationComposer a) f) {
    final $$MedicationCheckInsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.medicationCheckIns,
            getReferencedColumn: (t) => t.scheduleId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicationCheckInsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicationCheckIns,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MedicationSchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationSchedulesTable,
    MedicationSchedule,
    $$MedicationSchedulesTableFilterComposer,
    $$MedicationSchedulesTableOrderingComposer,
    $$MedicationSchedulesTableAnnotationComposer,
    $$MedicationSchedulesTableCreateCompanionBuilder,
    $$MedicationSchedulesTableUpdateCompanionBuilder,
    (MedicationSchedule, $$MedicationSchedulesTableReferences),
    MedicationSchedule,
    PrefetchHooks Function({bool petId, bool medicationCheckInsRefs})> {
  $$MedicationSchedulesTableTableManager(
      _$AppDatabase db, $MedicationSchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationSchedulesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationSchedulesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> medicationName = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String> reminderTimes = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MedicationSchedulesCompanion(
            id: id,
            petId: petId,
            medicationName: medicationName,
            dosage: dosage,
            frequency: frequency,
            startDate: startDate,
            endDate: endDate,
            reminderTimes: reminderTimes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String petId,
            required String medicationName,
            required String dosage,
            required String frequency,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            required String reminderTimes,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MedicationSchedulesCompanion.insert(
            id: id,
            petId: petId,
            medicationName: medicationName,
            dosage: dosage,
            frequency: frequency,
            startDate: startDate,
            endDate: endDate,
            reminderTimes: reminderTimes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicationSchedulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {petId = false, medicationCheckInsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (medicationCheckInsRefs) db.medicationCheckIns
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (petId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.petId,
                    referencedTable:
                        $$MedicationSchedulesTableReferences._petIdTable(db),
                    referencedColumn: $$MedicationSchedulesTableReferences
                        ._petIdTable(db)
                        .petId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (medicationCheckInsRefs)
                    await $_getPrefetchedData<MedicationSchedule,
                            $MedicationSchedulesTable, MedicationCheckIn>(
                        currentTable: table,
                        referencedTable: $$MedicationSchedulesTableReferences
                            ._medicationCheckInsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MedicationSchedulesTableReferences(db, table, p0)
                                .medicationCheckInsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.scheduleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MedicationSchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationSchedulesTable,
    MedicationSchedule,
    $$MedicationSchedulesTableFilterComposer,
    $$MedicationSchedulesTableOrderingComposer,
    $$MedicationSchedulesTableAnnotationComposer,
    $$MedicationSchedulesTableCreateCompanionBuilder,
    $$MedicationSchedulesTableUpdateCompanionBuilder,
    (MedicationSchedule, $$MedicationSchedulesTableReferences),
    MedicationSchedule,
    PrefetchHooks Function({bool petId, bool medicationCheckInsRefs})>;
typedef $$MedicationCheckInsTableCreateCompanionBuilder
    = MedicationCheckInsCompanion Function({
  Value<int> id,
  required int scheduleId,
  Value<DateTime> timestamp,
  required DateTime plannedTimestamp,
  Value<bool> isTaken,
  Value<String?> completedBy,
  Value<String?> completedByName,
  Value<String?> notes,
});
typedef $$MedicationCheckInsTableUpdateCompanionBuilder
    = MedicationCheckInsCompanion Function({
  Value<int> id,
  Value<int> scheduleId,
  Value<DateTime> timestamp,
  Value<DateTime> plannedTimestamp,
  Value<bool> isTaken,
  Value<String?> completedBy,
  Value<String?> completedByName,
  Value<String?> notes,
});

final class $$MedicationCheckInsTableReferences extends BaseReferences<
    _$AppDatabase, $MedicationCheckInsTable, MedicationCheckIn> {
  $$MedicationCheckInsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MedicationSchedulesTable _scheduleIdTable(_$AppDatabase db) =>
      db.medicationSchedules.createAlias($_aliasNameGenerator(
          db.medicationCheckIns.scheduleId, db.medicationSchedules.id));

  $$MedicationSchedulesTableProcessedTableManager get scheduleId {
    final $_column = $_itemColumn<int>('schedule_id')!;

    final manager =
        $$MedicationSchedulesTableTableManager($_db, $_db.medicationSchedules)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MedicationCheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationCheckInsTable> {
  $$MedicationCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTaken => $composableBuilder(
      column: $table.isTaken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedByName => $composableBuilder(
      column: $table.completedByName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  $$MedicationSchedulesTableFilterComposer get scheduleId {
    final $$MedicationSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.medicationSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.medicationSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationCheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationCheckInsTable> {
  $$MedicationCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTaken => $composableBuilder(
      column: $table.isTaken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedByName => $composableBuilder(
      column: $table.completedByName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$MedicationSchedulesTableOrderingComposer get scheduleId {
    final $$MedicationSchedulesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.scheduleId,
            referencedTable: $db.medicationSchedules,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicationSchedulesTableOrderingComposer(
                  $db: $db,
                  $table: $db.medicationSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MedicationCheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationCheckInsTable> {
  $$MedicationCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp, builder: (column) => column);

  GeneratedColumn<bool> get isTaken =>
      $composableBuilder(column: $table.isTaken, builder: (column) => column);

  GeneratedColumn<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => column);

  GeneratedColumn<String> get completedByName => $composableBuilder(
      column: $table.completedByName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$MedicationSchedulesTableAnnotationComposer get scheduleId {
    final $$MedicationSchedulesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.scheduleId,
            referencedTable: $db.medicationSchedules,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicationSchedulesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicationSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MedicationCheckInsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationCheckInsTable,
    MedicationCheckIn,
    $$MedicationCheckInsTableFilterComposer,
    $$MedicationCheckInsTableOrderingComposer,
    $$MedicationCheckInsTableAnnotationComposer,
    $$MedicationCheckInsTableCreateCompanionBuilder,
    $$MedicationCheckInsTableUpdateCompanionBuilder,
    (MedicationCheckIn, $$MedicationCheckInsTableReferences),
    MedicationCheckIn,
    PrefetchHooks Function({bool scheduleId})> {
  $$MedicationCheckInsTableTableManager(
      _$AppDatabase db, $MedicationCheckInsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationCheckInsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> scheduleId = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<DateTime> plannedTimestamp = const Value.absent(),
            Value<bool> isTaken = const Value.absent(),
            Value<String?> completedBy = const Value.absent(),
            Value<String?> completedByName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MedicationCheckInsCompanion(
            id: id,
            scheduleId: scheduleId,
            timestamp: timestamp,
            plannedTimestamp: plannedTimestamp,
            isTaken: isTaken,
            completedBy: completedBy,
            completedByName: completedByName,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int scheduleId,
            Value<DateTime> timestamp = const Value.absent(),
            required DateTime plannedTimestamp,
            Value<bool> isTaken = const Value.absent(),
            Value<String?> completedBy = const Value.absent(),
            Value<String?> completedByName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MedicationCheckInsCompanion.insert(
            id: id,
            scheduleId: scheduleId,
            timestamp: timestamp,
            plannedTimestamp: plannedTimestamp,
            isTaken: isTaken,
            completedBy: completedBy,
            completedByName: completedByName,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicationCheckInsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({scheduleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (scheduleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.scheduleId,
                    referencedTable: $$MedicationCheckInsTableReferences
                        ._scheduleIdTable(db),
                    referencedColumn: $$MedicationCheckInsTableReferences
                        ._scheduleIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MedicationCheckInsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationCheckInsTable,
    MedicationCheckIn,
    $$MedicationCheckInsTableFilterComposer,
    $$MedicationCheckInsTableOrderingComposer,
    $$MedicationCheckInsTableAnnotationComposer,
    $$MedicationCheckInsTableCreateCompanionBuilder,
    $$MedicationCheckInsTableUpdateCompanionBuilder,
    (MedicationCheckIn, $$MedicationCheckInsTableReferences),
    MedicationCheckIn,
    PrefetchHooks Function({bool scheduleId})>;
typedef $$FeedingSchedulesTableCreateCompanionBuilder
    = FeedingSchedulesCompanion Function({
  Value<int> id,
  required String petId,
  required String foodType,
  required String amount,
  required String reminderTimes,
  Value<String?> notes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$FeedingSchedulesTableUpdateCompanionBuilder
    = FeedingSchedulesCompanion Function({
  Value<int> id,
  Value<String> petId,
  Value<String> foodType,
  Value<String> amount,
  Value<String> reminderTimes,
  Value<String?> notes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$FeedingSchedulesTableReferences extends BaseReferences<
    _$AppDatabase, $FeedingSchedulesTable, FeedingSchedule> {
  $$FeedingSchedulesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDatabase db) => db.pets.createAlias(
      $_aliasNameGenerator(db.feedingSchedules.petId, db.pets.petId));

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<String>('pet_id')!;

    final manager = $$PetsTableTableManager($_db, $_db.pets)
        .filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FeedingCheckInsTable, List<FeedingCheckIn>>
      _feedingCheckInsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.feedingCheckIns,
              aliasName: $_aliasNameGenerator(
                  db.feedingSchedules.id, db.feedingCheckIns.scheduleId));

  $$FeedingCheckInsTableProcessedTableManager get feedingCheckInsRefs {
    final manager =
        $$FeedingCheckInsTableTableManager($_db, $_db.feedingCheckIns)
            .filter((f) => f.scheduleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_feedingCheckInsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FeedingSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodType => $composableBuilder(
      column: $table.foodType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableFilterComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> feedingCheckInsRefs(
      Expression<bool> Function($$FeedingCheckInsTableFilterComposer f) f) {
    final $$FeedingCheckInsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feedingCheckIns,
        getReferencedColumn: (t) => t.scheduleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingCheckInsTableFilterComposer(
              $db: $db,
              $table: $db.feedingCheckIns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FeedingSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodType => $composableBuilder(
      column: $table.foodType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableOrderingComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedingSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodType =>
      $composableBuilder(column: $table.foodType, builder: (column) => column);

  GeneratedColumn<String> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reminderTimes => $composableBuilder(
      column: $table.reminderTimes, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableAnnotationComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> feedingCheckInsRefs<T extends Object>(
      Expression<T> Function($$FeedingCheckInsTableAnnotationComposer a) f) {
    final $$FeedingCheckInsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feedingCheckIns,
        getReferencedColumn: (t) => t.scheduleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingCheckInsTableAnnotationComposer(
              $db: $db,
              $table: $db.feedingCheckIns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FeedingSchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedingSchedulesTable,
    FeedingSchedule,
    $$FeedingSchedulesTableFilterComposer,
    $$FeedingSchedulesTableOrderingComposer,
    $$FeedingSchedulesTableAnnotationComposer,
    $$FeedingSchedulesTableCreateCompanionBuilder,
    $$FeedingSchedulesTableUpdateCompanionBuilder,
    (FeedingSchedule, $$FeedingSchedulesTableReferences),
    FeedingSchedule,
    PrefetchHooks Function({bool petId, bool feedingCheckInsRefs})> {
  $$FeedingSchedulesTableTableManager(
      _$AppDatabase db, $FeedingSchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> foodType = const Value.absent(),
            Value<String> amount = const Value.absent(),
            Value<String> reminderTimes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedingSchedulesCompanion(
            id: id,
            petId: petId,
            foodType: foodType,
            amount: amount,
            reminderTimes: reminderTimes,
            notes: notes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String petId,
            required String foodType,
            required String amount,
            required String reminderTimes,
            Value<String?> notes = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedingSchedulesCompanion.insert(
            id: id,
            petId: petId,
            foodType: foodType,
            amount: amount,
            reminderTimes: reminderTimes,
            notes: notes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeedingSchedulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {petId = false, feedingCheckInsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feedingCheckInsRefs) db.feedingCheckIns
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (petId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.petId,
                    referencedTable:
                        $$FeedingSchedulesTableReferences._petIdTable(db),
                    referencedColumn:
                        $$FeedingSchedulesTableReferences._petIdTable(db).petId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedingCheckInsRefs)
                    await $_getPrefetchedData<FeedingSchedule,
                            $FeedingSchedulesTable, FeedingCheckIn>(
                        currentTable: table,
                        referencedTable: $$FeedingSchedulesTableReferences
                            ._feedingCheckInsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeedingSchedulesTableReferences(db, table, p0)
                                .feedingCheckInsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.scheduleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FeedingSchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedingSchedulesTable,
    FeedingSchedule,
    $$FeedingSchedulesTableFilterComposer,
    $$FeedingSchedulesTableOrderingComposer,
    $$FeedingSchedulesTableAnnotationComposer,
    $$FeedingSchedulesTableCreateCompanionBuilder,
    $$FeedingSchedulesTableUpdateCompanionBuilder,
    (FeedingSchedule, $$FeedingSchedulesTableReferences),
    FeedingSchedule,
    PrefetchHooks Function({bool petId, bool feedingCheckInsRefs})>;
typedef $$FeedingCheckInsTableCreateCompanionBuilder = FeedingCheckInsCompanion
    Function({
  Value<int> id,
  required int scheduleId,
  Value<DateTime> timestamp,
  required DateTime plannedTimestamp,
  Value<String?> completedBy,
  Value<String?> completedByName,
  Value<String?> notes,
});
typedef $$FeedingCheckInsTableUpdateCompanionBuilder = FeedingCheckInsCompanion
    Function({
  Value<int> id,
  Value<int> scheduleId,
  Value<DateTime> timestamp,
  Value<DateTime> plannedTimestamp,
  Value<String?> completedBy,
  Value<String?> completedByName,
  Value<String?> notes,
});

final class $$FeedingCheckInsTableReferences extends BaseReferences<
    _$AppDatabase, $FeedingCheckInsTable, FeedingCheckIn> {
  $$FeedingCheckInsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FeedingSchedulesTable _scheduleIdTable(_$AppDatabase db) =>
      db.feedingSchedules.createAlias($_aliasNameGenerator(
          db.feedingCheckIns.scheduleId, db.feedingSchedules.id));

  $$FeedingSchedulesTableProcessedTableManager get scheduleId {
    final $_column = $_itemColumn<int>('schedule_id')!;

    final manager =
        $$FeedingSchedulesTableTableManager($_db, $_db.feedingSchedules)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FeedingCheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingCheckInsTable> {
  $$FeedingCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedByName => $composableBuilder(
      column: $table.completedByName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  $$FeedingSchedulesTableFilterComposer get scheduleId {
    final $$FeedingSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.feedingSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.feedingSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedingCheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingCheckInsTable> {
  $$FeedingCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedByName => $composableBuilder(
      column: $table.completedByName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$FeedingSchedulesTableOrderingComposer get scheduleId {
    final $$FeedingSchedulesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.feedingSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingSchedulesTableOrderingComposer(
              $db: $db,
              $table: $db.feedingSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedingCheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingCheckInsTable> {
  $$FeedingCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedTimestamp => $composableBuilder(
      column: $table.plannedTimestamp, builder: (column) => column);

  GeneratedColumn<String> get completedBy => $composableBuilder(
      column: $table.completedBy, builder: (column) => column);

  GeneratedColumn<String> get completedByName => $composableBuilder(
      column: $table.completedByName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$FeedingSchedulesTableAnnotationComposer get scheduleId {
    final $$FeedingSchedulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.feedingSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedingSchedulesTableAnnotationComposer(
              $db: $db,
              $table: $db.feedingSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedingCheckInsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedingCheckInsTable,
    FeedingCheckIn,
    $$FeedingCheckInsTableFilterComposer,
    $$FeedingCheckInsTableOrderingComposer,
    $$FeedingCheckInsTableAnnotationComposer,
    $$FeedingCheckInsTableCreateCompanionBuilder,
    $$FeedingCheckInsTableUpdateCompanionBuilder,
    (FeedingCheckIn, $$FeedingCheckInsTableReferences),
    FeedingCheckIn,
    PrefetchHooks Function({bool scheduleId})> {
  $$FeedingCheckInsTableTableManager(
      _$AppDatabase db, $FeedingCheckInsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingCheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> scheduleId = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<DateTime> plannedTimestamp = const Value.absent(),
            Value<String?> completedBy = const Value.absent(),
            Value<String?> completedByName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              FeedingCheckInsCompanion(
            id: id,
            scheduleId: scheduleId,
            timestamp: timestamp,
            plannedTimestamp: plannedTimestamp,
            completedBy: completedBy,
            completedByName: completedByName,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int scheduleId,
            Value<DateTime> timestamp = const Value.absent(),
            required DateTime plannedTimestamp,
            Value<String?> completedBy = const Value.absent(),
            Value<String?> completedByName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              FeedingCheckInsCompanion.insert(
            id: id,
            scheduleId: scheduleId,
            timestamp: timestamp,
            plannedTimestamp: plannedTimestamp,
            completedBy: completedBy,
            completedByName: completedByName,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeedingCheckInsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({scheduleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (scheduleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.scheduleId,
                    referencedTable:
                        $$FeedingCheckInsTableReferences._scheduleIdTable(db),
                    referencedColumn: $$FeedingCheckInsTableReferences
                        ._scheduleIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FeedingCheckInsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedingCheckInsTable,
    FeedingCheckIn,
    $$FeedingCheckInsTableFilterComposer,
    $$FeedingCheckInsTableOrderingComposer,
    $$FeedingCheckInsTableAnnotationComposer,
    $$FeedingCheckInsTableCreateCompanionBuilder,
    $$FeedingCheckInsTableUpdateCompanionBuilder,
    (FeedingCheckIn, $$FeedingCheckInsTableReferences),
    FeedingCheckIn,
    PrefetchHooks Function({bool scheduleId})>;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  required String petId,
  required String name,
  required String type,
  Value<DateTime> date,
  required String filePath,
  Value<String?> tags,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<String> petId,
  Value<String> name,
  Value<String> type,
  Value<DateTime> date,
  Value<String> filePath,
  Value<String?> tags,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDatabase db) => db.pets
      .createAlias($_aliasNameGenerator(db.documents.petId, db.pets.petId));

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<String>('pet_id')!;

    final manager = $$PetsTableTableManager($_db, $_db.pets)
        .filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableFilterComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableOrderingComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.petId,
        referencedTable: $db.pets,
        getReferencedColumn: (t) => t.petId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PetsTableAnnotationComposer(
              $db: $db,
              $table: $db.pets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DocumentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, $$DocumentsTableReferences),
    Document,
    PrefetchHooks Function({bool petId})> {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DocumentsCompanion(
            id: id,
            petId: petId,
            name: name,
            type: type,
            date: date,
            filePath: filePath,
            tags: tags,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String petId,
            required String name,
            required String type,
            Value<DateTime> date = const Value.absent(),
            required String filePath,
            Value<String?> tags = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DocumentsCompanion.insert(
            id: id,
            petId: petId,
            name: name,
            type: type,
            date: date,
            filePath: filePath,
            tags: tags,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DocumentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (petId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.petId,
                    referencedTable: $$DocumentsTableReferences._petIdTable(db),
                    referencedColumn:
                        $$DocumentsTableReferences._petIdTable(db).petId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DocumentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, $$DocumentsTableReferences),
    Document,
    PrefetchHooks Function({bool petId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db, _db.households);
  $$HouseholdMembersTableTableManager get householdMembers =>
      $$HouseholdMembersTableTableManager(_db, _db.householdMembers);
  $$HouseholdInvitationsTableTableManager get householdInvitations =>
      $$HouseholdInvitationsTableTableManager(_db, _db.householdInvitations);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$MedicationSchedulesTableTableManager get medicationSchedules =>
      $$MedicationSchedulesTableTableManager(_db, _db.medicationSchedules);
  $$MedicationCheckInsTableTableManager get medicationCheckIns =>
      $$MedicationCheckInsTableTableManager(_db, _db.medicationCheckIns);
  $$FeedingSchedulesTableTableManager get feedingSchedules =>
      $$FeedingSchedulesTableTableManager(_db, _db.feedingSchedules);
  $$FeedingCheckInsTableTableManager get feedingCheckIns =>
      $$FeedingCheckInsTableTableManager(_db, _db.feedingCheckIns);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
}
