// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_data_crud.dart';

// ignore_for_file: type=lint
class $TodoItemTable extends TodoItem
    with TableInfo<$TodoItemTable, TodoItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
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
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _shujitsuBoolMeta =
      const VerificationMeta('shujitsuBool');
  @override
  late final GeneratedColumn<bool> shujitsuBool =
      GeneratedColumn<bool>('shujitsu_bool', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("shujitsu_bool" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, startDate, endDate, shujitsuBool];
  @override
  String get aliasedName => _alias ?? 'todo_item';
  @override
  String get actualTableName => 'todo_item';
  @override
  VerificationContext validateIntegrity(Insertable<TodoItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
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
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('shujitsu_bool')) {
      context.handle(
          _shujitsuBoolMeta,
          shujitsuBool.isAcceptableOrUnknown(
              data['shujitsu_bool']!, _shujitsuBoolMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      shujitsuBool: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}shujitsu_bool'])!,
    );
  }

  @override
  $TodoItemTable createAlias(String alias) {
    return $TodoItemTable(attachedDatabase, alias);
  }
}

class TodoItemData extends DataClass implements Insertable<TodoItemData> {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool shujitsuBool;
  const TodoItemData(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.shujitsuBool});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['shujitsu_bool'] = Variable<bool>(shujitsuBool);
    return map;
  }

  TodoItemCompanion toCompanion(bool nullToAbsent) {
    return TodoItemCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      shujitsuBool: Value(shujitsuBool),
    );
  }

  factory TodoItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      shujitsuBool: serializer.fromJson<bool>(json['shujitsuBool']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'shujitsuBool': serializer.toJson<bool>(shujitsuBool),
    };
  }

  TodoItemData copyWith(
          {String? id,
          String? title,
          String? description,
          DateTime? startDate,
          DateTime? endDate,
          bool? shujitsuBool}) =>
      TodoItemData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        shujitsuBool: shujitsuBool ?? this.shujitsuBool,
      );
  @override
  String toString() {
    return (StringBuffer('TodoItemData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('shujitsuBool: $shujitsuBool')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, startDate, endDate, shujitsuBool);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItemData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.shujitsuBool == this.shujitsuBool);
}

class TodoItemCompanion extends UpdateCompanion<TodoItemData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> shujitsuBool;
  const TodoItemCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.shujitsuBool = const Value.absent(),
  });
  TodoItemCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.shujitsuBool = const Value.absent(),
  })  : id = Value(id),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<TodoItemData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? shujitsuBool,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (shujitsuBool != null) 'shujitsu_bool': shujitsuBool,
    });
  }

  TodoItemCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<bool>? shujitsuBool}) {
    return TodoItemCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      shujitsuBool: shujitsuBool ?? this.shujitsuBool,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (shujitsuBool.present) {
      map['shujitsu_bool'] = Variable<bool>(shujitsuBool.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('shujitsuBool: $shujitsuBool')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $TodoItemTable todoItem = $TodoItemTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItem];
}
