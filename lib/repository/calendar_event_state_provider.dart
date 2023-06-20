import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final calendarEventProvider =
    StateNotifierProvider<CalendarEventStateNotifier, CalendarEvent>((ref) {
  return CalendarEventStateNotifier(CalendarEvent(
    id: const Uuid().v1(),
    title: '',
    description: '',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    isAllDay: false,
  ));
});

class CalendarEventStateNotifier extends StateNotifier<CalendarEvent> {
  CalendarEventStateNotifier(CalendarEvent state) : super(state);

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void updateEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void updateIsAllDay(bool isAllDay) {
    state = state.copyWith(isAllDay: isAllDay);
  }
}
