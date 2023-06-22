import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/domain/calendar_todo_state_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventStateProvider =
    StateNotifierProvider<CalendarEventStateNotifier, CalendarTodoStateMap>(
        (ref) {
  return CalendarEventStateNotifier(ref);
});

// データベースに追加されたデータをMap型のリストに代入して返すクラス。
class CalendarEventStateNotifier extends StateNotifier<CalendarTodoStateMap> {
  CalendarEventStateNotifier(this.ref) : super(CalendarTodoStateMap());

  final Ref ref;
  MyDatabase database = MyDatabase();

  // 取得したデータをMap型の変数に格納して扱う。
  Future<void> readDataMap() async {
    final eventsAll = await database.readAllTodoData(); // 全てのデータを取得

    state = state.copyWith(todoItemsMap: {});
    final Map<DateTime, List<CalendarEvent>> dataMap = {}; // 最初はリストは空。

    final todoList = List.generate(
      eventsAll.length,
      (index) => CalendarEvent(
        id: eventsAll[index].id,
        title: eventsAll[index].title,
        isAllDay: eventsAll[index].shujitsuBool,
        startDate: eventsAll[index].startDate,
        endDate: eventsAll[index].endDate,
        description: eventsAll[index].description,
      ),
    );

    for (final e in todoList) {
      // 開始日
      final startDay =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);

      // 終了日
      final endDay = DateTime(e.endDate.year, e.endDate.month, e.endDate.day);

      // 開始日と終了日の差を計算
      var difference = endDay.difference(startDay).inDays;

      for (int i = 0; i <= difference; i++) {
        final date =
            DateTime(e.startDate.year, e.startDate.month, e.startDate.day + i);

        // 追加された日にちをMap型に落とし込む。
        if (state.todoItemsMap[date] == null) {
          dataMap[date] = [e];
          state = state.copyWith(todoItemsMap: dataMap);
        } else {
          if (dataMap[date] == null) {
            dataMap[date] = [e];
            state = state.copyWith(todoItemsMap: dataMap);
          } else {
            dataMap[date]!.add(e);
            state = state.copyWith(todoItemsMap: dataMap);
          }
        }
      }
    }
  }
}
