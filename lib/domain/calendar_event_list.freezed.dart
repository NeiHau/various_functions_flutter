// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalendarEventList {
  List<CalendarEvent> get todoItems => throw _privateConstructorUsedError;
  bool get isUpdated => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarEventListCopyWith<CalendarEventList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventListCopyWith<$Res> {
  factory $CalendarEventListCopyWith(
          CalendarEventList value, $Res Function(CalendarEventList) then) =
      _$CalendarEventListCopyWithImpl<$Res, CalendarEventList>;
  @useResult
  $Res call({List<CalendarEvent> todoItems, bool isUpdated});
}

/// @nodoc
class _$CalendarEventListCopyWithImpl<$Res, $Val extends CalendarEventList>
    implements $CalendarEventListCopyWith<$Res> {
  _$CalendarEventListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItems = null,
    Object? isUpdated = null,
  }) {
    return _then(_value.copyWith(
      todoItems: null == todoItems
          ? _value.todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      isUpdated: null == isUpdated
          ? _value.isUpdated
          : isUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalendarEventListCopyWith<$Res>
    implements $CalendarEventListCopyWith<$Res> {
  factory _$$_CalendarEventListCopyWith(_$_CalendarEventList value,
          $Res Function(_$_CalendarEventList) then) =
      __$$_CalendarEventListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CalendarEvent> todoItems, bool isUpdated});
}

/// @nodoc
class __$$_CalendarEventListCopyWithImpl<$Res>
    extends _$CalendarEventListCopyWithImpl<$Res, _$_CalendarEventList>
    implements _$$_CalendarEventListCopyWith<$Res> {
  __$$_CalendarEventListCopyWithImpl(
      _$_CalendarEventList _value, $Res Function(_$_CalendarEventList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItems = null,
    Object? isUpdated = null,
  }) {
    return _then(_$_CalendarEventList(
      todoItems: null == todoItems
          ? _value._todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      isUpdated: null == isUpdated
          ? _value.isUpdated
          : isUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CalendarEventList implements _CalendarEventList {
  _$_CalendarEventList(
      {final List<CalendarEvent> todoItems = const [], this.isUpdated = false})
      : _todoItems = todoItems;

  final List<CalendarEvent> _todoItems;
  @override
  @JsonKey()
  List<CalendarEvent> get todoItems {
    if (_todoItems is EqualUnmodifiableListView) return _todoItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoItems);
  }

  @override
  @JsonKey()
  final bool isUpdated;

  @override
  String toString() {
    return 'CalendarEventList(todoItems: $todoItems, isUpdated: $isUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalendarEventList &&
            const DeepCollectionEquality()
                .equals(other._todoItems, _todoItems) &&
            (identical(other.isUpdated, isUpdated) ||
                other.isUpdated == isUpdated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_todoItems), isUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalendarEventListCopyWith<_$_CalendarEventList> get copyWith =>
      __$$_CalendarEventListCopyWithImpl<_$_CalendarEventList>(
          this, _$identity);
}

abstract class _CalendarEventList implements CalendarEventList {
  factory _CalendarEventList(
      {final List<CalendarEvent> todoItems,
      final bool isUpdated}) = _$_CalendarEventList;

  @override
  List<CalendarEvent> get todoItems;
  @override
  bool get isUpdated;
  @override
  @JsonKey(ignore: true)
  _$$_CalendarEventListCopyWith<_$_CalendarEventList> get copyWith =>
      throw _privateConstructorUsedError;
}
