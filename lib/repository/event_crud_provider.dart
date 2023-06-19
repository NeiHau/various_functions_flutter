import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/domain/calendar_event_list.dart';
import 'package:calendar_app_remake/repository/event_map_provider.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoDatabaseProvider =
    StateNotifierProvider<TodoDatabaseNotifier, CalendarEventList>((ref) {
  return TodoDatabaseNotifier(ref);
});

// データベースの状態が変わるたびTodoListのviewをビルドするクラス。
class TodoDatabaseNotifier extends StateNotifier<CalendarEventList> {
  TodoDatabaseNotifier(this.ref) : super(CalendarEventList());

  final Ref ref;
  final _db = MyDatabase();

  // 書き込み処理部分
  Future<void> writeData(TodoItemData data) async {
    TodoItemCompanion entry = TodoItemCompanion(
      id: Value(data.id),
      title: Value(data.title),
      startDate: Value(data.startDate),
      endDate: Value(data.endDate),
      description: Value(data.description),
      shujitsuBool: Value(data.shujitsuBool),
    );

    await _db.writeTodo(entry);

    // 書き込むたびにデータベースを読み込んで、マップ型のデータに格納する。
    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // 削除処理部分
  Future<void> deleteData(CalendarEvent data) async {
    await _db.deleteTodo(data);

    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // 更新処理部分
  Future<void> updateData(TodoItemData data) async {
    await _db.updateTodo(data);

    // 更新するたびにデータベースを読み込む。
    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // データ読み込み処理
  Future<void> readData() async {
    final todoItems = await _db.readAllTodoData();

    List<CalendarEvent> todoList = [];
    for (int i = 0; i < todoItems.length; i++) {
      todoList.add(CalendarEvent(
          id: todoItems[i].id,
          title: todoItems[i].title,
          description: todoItems[i].description,
          startDate: todoItems[i].startDate,
          endDate: todoItems[i].endDate,
          isAllDay: todoItems[i].shujitsuBool));
    }

    state = state.copyWith(
      todoItems: todoList,
    );
  }
}
