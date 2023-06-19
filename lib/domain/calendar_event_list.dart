import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event_list.freezed.dart';

@freezed
class CalendarEventList with _$CalendarEventList {
  // データベースの状態を管理するクラス。
  factory CalendarEventList({
    @Default([]) List<CalendarEvent> todoItems,
    @Default(false) bool isUpdated,
  }) = _CalendarEventList;
}
