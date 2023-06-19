import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/repository/event_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarEventListView extends ConsumerWidget {
  CalendarEventListView({required this.currentDate, super.key});

  final DateTime currentDate;
  List<Widget> list = []; // １日から最終日を格納するリスト。

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventStateProvider);
    // リストで表示したいイベント
    final currentEvents = state.todoItemsMap[currentDate];
    List<Widget> tiles = [];

    // 全てのtileを格納するリスト
    if (currentEvents != null) {
      tiles = buildTodoList(context, currentEvents);
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: (list.isEmpty)
            ? const Center(
                child: Text('予定がありません'),
              )
            : ListView(children: tiles),
      ),
    );
  }

  // 予定追加画面において、todoリストを作成するメソッド。
  List<Widget> buildTodoList(
      BuildContext context, List<CalendarEvent> currentEvents) {
    // currentEvents != null 入っているイベントをリストで表示
    for (CalendarEvent item in currentEvents) {
      Widget tile = Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0,
            color: Colors.grey[200]!,
          ),
        )),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/EditingPage", arguments: item),
          child: ListTile(
            tileColor: Colors.white,
            leading: (item.isAllDay == true)
                ? const Text('終日')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat('HH:mm').format(item.startDate)),
                      Text(DateFormat('HH:mm').format(item.endDate)),
                    ],
                  ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blue,
                  child: const VerticalDivider(
                    color: Colors.blue,
                    thickness: 1,
                    indent: 50,
                    width: 4,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Title(
                  color: Colors.black,
                  child: Flexible(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      list.add(tile);
    }
    return list;
  }
}
