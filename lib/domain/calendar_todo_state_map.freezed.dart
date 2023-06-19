// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_todo_state_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalendarTodoStateMap {
  ///Map<日付:イベント>
  Map<DateTime, List<CalendarEvent>> get todoItemsMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarTodoStateMapCopyWith<CalendarTodoStateMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarTodoStateMapCopyWith<$Res> {
  factory $CalendarTodoStateMapCopyWith(CalendarTodoStateMap value,
          $Res Function(CalendarTodoStateMap) then) =
      _$CalendarTodoStateMapCopyWithImpl<$Res, CalendarTodoStateMap>;
  @useResult
  $Res call({Map<DateTime, List<CalendarEvent>> todoItemsMap});
}

/// @nodoc
class _$CalendarTodoStateMapCopyWithImpl<$Res,
        $Val extends CalendarTodoStateMap>
    implements $CalendarTodoStateMapCopyWith<$Res> {
  _$CalendarTodoStateMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItemsMap = null,
  }) {
    return _then(_value.copyWith(
      todoItemsMap: null == todoItemsMap
          ? _value.todoItemsMap
          : todoItemsMap // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<CalendarEvent>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalendarTodoStateMapCopyWith<$Res>
    implements $CalendarTodoStateMapCopyWith<$Res> {
  factory _$$_CalendarTodoStateMapCopyWith(_$_CalendarTodoStateMap value,
          $Res Function(_$_CalendarTodoStateMap) then) =
      __$$_CalendarTodoStateMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<DateTime, List<CalendarEvent>> todoItemsMap});
}

/// @nodoc
class __$$_CalendarTodoStateMapCopyWithImpl<$Res>
    extends _$CalendarTodoStateMapCopyWithImpl<$Res, _$_CalendarTodoStateMap>
    implements _$$_CalendarTodoStateMapCopyWith<$Res> {
  __$$_CalendarTodoStateMapCopyWithImpl(_$_CalendarTodoStateMap _value,
      $Res Function(_$_CalendarTodoStateMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItemsMap = null,
  }) {
    return _then(_$_CalendarTodoStateMap(
      todoItemsMap: null == todoItemsMap
          ? _value._todoItemsMap
          : todoItemsMap // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<CalendarEvent>>,
    ));
  }
}

/// @nodoc

class _$_CalendarTodoStateMap implements _CalendarTodoStateMap {
  _$_CalendarTodoStateMap(
      {final Map<DateTime, List<CalendarEvent>> todoItemsMap = const {}})
      : _todoItemsMap = todoItemsMap;

  ///Map<日付:イベント>
  final Map<DateTime, List<CalendarEvent>> _todoItemsMap;

  ///Map<日付:イベント>
  @override
  @JsonKey()
  Map<DateTime, List<CalendarEvent>> get todoItemsMap {
    if (_todoItemsMap is EqualUnmodifiableMapView) return _todoItemsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_todoItemsMap);
  }

  @override
  String toString() {
    return 'CalendarTodoStateMap(todoItemsMap: $todoItemsMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalendarTodoStateMap &&
            const DeepCollectionEquality()
                .equals(other._todoItemsMap, _todoItemsMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_todoItemsMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalendarTodoStateMapCopyWith<_$_CalendarTodoStateMap> get copyWith =>
      __$$_CalendarTodoStateMapCopyWithImpl<_$_CalendarTodoStateMap>(
          this, _$identity);
}

abstract class _CalendarTodoStateMap implements CalendarTodoStateMap {
  factory _CalendarTodoStateMap(
          {final Map<DateTime, List<CalendarEvent>> todoItemsMap}) =
      _$_CalendarTodoStateMap;

  @override

  ///Map<日付:イベント>
  Map<DateTime, List<CalendarEvent>> get todoItemsMap;
  @override
  @JsonKey(ignore: true)
  _$$_CalendarTodoStateMapCopyWith<_$_CalendarTodoStateMap> get copyWith =>
      throw _privateConstructorUsedError;
}
