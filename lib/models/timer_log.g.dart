// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerLogCollection on Isar {
  IsarCollection<TimerLog> get timerLogs => this.collection();
}

const TimerLogSchema = CollectionSchema(
  name: r'TimerLog',
  id: 1911096440365979997,
  properties: {
    r'duration': PropertySchema(
      id: 0,
      name: r'duration',
      type: IsarType.long,
    ),
    r'habitId': PropertySchema(
      id: 1,
      name: r'habitId',
      type: IsarType.long,
    ),
    r'isTimerActive': PropertySchema(
      id: 2,
      name: r'isTimerActive',
      type: IsarType.bool,
    ),
    r'startTime': PropertySchema(
      id: 3,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'targetEndTime': PropertySchema(
      id: 4,
      name: r'targetEndTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _timerLogEstimateSize,
  serialize: _timerLogSerialize,
  deserialize: _timerLogDeserialize,
  deserializeProp: _timerLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timerLogGetId,
  getLinks: _timerLogGetLinks,
  attach: _timerLogAttach,
  version: '3.1.0+1',
);

int _timerLogEstimateSize(
  TimerLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _timerLogSerialize(
  TimerLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.duration);
  writer.writeLong(offsets[1], object.habitId);
  writer.writeBool(offsets[2], object.isTimerActive);
  writer.writeDateTime(offsets[3], object.startTime);
  writer.writeDateTime(offsets[4], object.targetEndTime);
}

TimerLog _timerLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimerLog();
  object.duration = reader.readLongOrNull(offsets[0]);
  object.habitId = reader.readLong(offsets[1]);
  object.id = id;
  object.isTimerActive = reader.readBool(offsets[2]);
  object.startTime = reader.readDateTimeOrNull(offsets[3]);
  object.targetEndTime = reader.readDateTimeOrNull(offsets[4]);
  return object;
}

P _timerLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timerLogGetId(TimerLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerLogGetLinks(TimerLog object) {
  return [];
}

void _timerLogAttach(IsarCollection<dynamic> col, Id id, TimerLog object) {
  object.id = id;
}

extension TimerLogQueryWhereSort on QueryBuilder<TimerLog, TimerLog, QWhere> {
  QueryBuilder<TimerLog, TimerLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimerLogQueryWhere on QueryBuilder<TimerLog, TimerLog, QWhereClause> {
  QueryBuilder<TimerLog, TimerLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerLogQueryFilter
    on QueryBuilder<TimerLog, TimerLog, QFilterCondition> {
  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> durationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> habitIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> habitIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> habitIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> habitIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'habitId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> isTimerActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTimerActive',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> startTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition>
      targetEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetEndTime',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition>
      targetEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetEndTime',
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> targetEndTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition>
      targetEndTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> targetEndTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterFilterCondition> targetEndTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerLogQueryObject
    on QueryBuilder<TimerLog, TimerLog, QFilterCondition> {}

extension TimerLogQueryLinks
    on QueryBuilder<TimerLog, TimerLog, QFilterCondition> {}

extension TimerLogQuerySortBy on QueryBuilder<TimerLog, TimerLog, QSortBy> {
  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByHabitIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByIsTimerActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerActive', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByIsTimerActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerActive', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByTargetEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetEndTime', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> sortByTargetEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetEndTime', Sort.desc);
    });
  }
}

extension TimerLogQuerySortThenBy
    on QueryBuilder<TimerLog, TimerLog, QSortThenBy> {
  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByHabitIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByIsTimerActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerActive', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByIsTimerActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTimerActive', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByTargetEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetEndTime', Sort.asc);
    });
  }

  QueryBuilder<TimerLog, TimerLog, QAfterSortBy> thenByTargetEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetEndTime', Sort.desc);
    });
  }
}

extension TimerLogQueryWhereDistinct
    on QueryBuilder<TimerLog, TimerLog, QDistinct> {
  QueryBuilder<TimerLog, TimerLog, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<TimerLog, TimerLog, QDistinct> distinctByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habitId');
    });
  }

  QueryBuilder<TimerLog, TimerLog, QDistinct> distinctByIsTimerActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTimerActive');
    });
  }

  QueryBuilder<TimerLog, TimerLog, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<TimerLog, TimerLog, QDistinct> distinctByTargetEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetEndTime');
    });
  }
}

extension TimerLogQueryProperty
    on QueryBuilder<TimerLog, TimerLog, QQueryProperty> {
  QueryBuilder<TimerLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimerLog, int?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<TimerLog, int, QQueryOperations> habitIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habitId');
    });
  }

  QueryBuilder<TimerLog, bool, QQueryOperations> isTimerActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTimerActive');
    });
  }

  QueryBuilder<TimerLog, DateTime?, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<TimerLog, DateTime?, QQueryOperations> targetEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetEndTime');
    });
  }
}
