import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_todo_state_map.freezed.dart';

@freezed
class CalendarTodoStateMap with _$CalendarTodoStateMap {
  // データベースの状態を管理するクラス。
  factory CalendarTodoStateMap({
    ///Map<日付:イベント>
    @Default({}) Map<DateTime, List<CalendarEvent>> todoItemsMap,
    //const factory @Default(true) Assert
  }) = _CalendarTodoStateMap;
}
