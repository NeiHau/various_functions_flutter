import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  factory CalendarEvent({
    required String id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isAllDay,
  }) = _CalendarEvent;
}
