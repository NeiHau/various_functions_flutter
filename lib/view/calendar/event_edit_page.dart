import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/repository/calendar_event_state_provider.dart';
import 'package:calendar_app_remake/repository/event_crud_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventEditingPage extends ConsumerStatefulWidget {
  const EventEditingPage({super.key, required this.arguments});

  // 追加画面から引き継いだデータ。
  final CalendarEvent arguments;

  @override
  ConsumerState<EventEditingPage> createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoDatabaseProvider);
    List<CalendarEvent> todoItems = state.todoItems;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Center(
          child: Text('予定の編集'),
        ),
        leading: const CloseButton(),
        actions: storeCalendarEvent(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              editTitle(),
              const SizedBox(height: 25, width: 10),
              selectShujitsuDay(),
              editDescription(),
              const SizedBox(height: 25, width: 10),
              deleteSchedule(todoItems, widget.arguments),
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを作成するメソッド
  List<Widget> storeCalendarEvent() {
    final state = ref.watch(calendarEventProvider);

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
        child: TextButton(
          onPressed: () {
            TodoItemData data = TodoItemData(
              id: state.id,
              title: state.title,
              description: state.description,
              startDate: state.startDate,
              endDate: state.endDate,
              shujitsuBool: state.isAllDay,
            );

            // 'todoprovider'でProviderのメソッドや値を取得。
            final todoProvider = ref.watch(todoDatabaseProvider.notifier);
            todoProvider.updateData(data);

            Navigator.popUntil(
              context,
              ModalRoute.withName("/"),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text('保存'),
        ),
      )
    ];
  }

  // タイトルを入力するメソッド
  Widget editTitle() {
    var state = ref.watch(calendarEventProvider);

    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          initialValue: widget.arguments.title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: UnderlineInputBorder(),
            hintText: 'タイトルを入力してください',
          ),
          onChanged: (value) {
            setState(() {
              state = state.copyWith(title: value);
            });
            ref.read(calendarEventProvider.notifier).updateTitle(value);
          },
        ),
      ),
    );
  }

  // 開始日と終了日を選択するメソッド
  Widget selectShujitsuDay() {
    var state = ref.watch(calendarEventProvider);

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('終日'),
            trailing: selectSwitch(0),
          ),
          ListTile(
            title: const Text('開始'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(
                state.isAllDay
                    ? DateFormat('yyyy-MM-dd').format(state.startDate)
                    : DateFormat('yyyy-MM-dd HH:mm').format(state.startDate),
              ),
              onPressed: () {
                cupertinoDatePicker(
                  CupertinoDatePicker(
                    initialDateTime: DateTime(
                      state.startDate.year,
                      state.startDate.month,
                      state.startDate.day,
                      state.startDate.hour,
                    ),
                    onDateTimeChanged: (value) {
                      setState(() {
                        state = state.copyWith(startDate: value);
                      });
                      ref
                          .read(calendarEventProvider.notifier)
                          .updateStartDate(value);
                    },
                    use24hFormat: true,
                    mode: state.isAllDay
                        ? CupertinoDatePickerMode.date
                        : CupertinoDatePickerMode.dateAndTime,
                    minuteInterval: 15,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text('終了'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(state.isAllDay
                  ? DateFormat('yyyy-MM-dd').format(state.endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(state.endDate)),
              onPressed: () {
                cupertinoDatePicker(
                  CupertinoDatePicker(
                    initialDateTime: DateTime(
                      state.endDate.year,
                      state.endDate.month,
                      state.endDate.day,
                      state.endDate.hour,
                    ),
                    onDateTimeChanged: (value) {
                      setState(() {
                        state = state.copyWith(endDate: value);
                      });
                      ref
                          .read(calendarEventProvider.notifier)
                          .updateEndDate(value);
                    },
                    use24hFormat: true,
                    mode: state.isAllDay
                        ? CupertinoDatePickerMode.date
                        : CupertinoDatePickerMode.dateAndTime,
                    minuteInterval: 15,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // 終日スイッチ
  Switch selectSwitch(int index) {
    var state = ref.watch(calendarEventProvider);

    return Switch(
      value: state.isAllDay,
      onChanged: (value) {
        setState(() {
          state = state.copyWith(isAllDay: value);
        });
        ref.read(calendarEventProvider.notifier).updateIsAllDay(value);
      },
    );
  }

  // コメント入力するフォームを作成するメソッド
  Widget editDescription() {
    var state = ref.watch(calendarEventProvider);

    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          initialValue: widget.arguments.description,
          onChanged: (value) {
            state = state.copyWith(description: value);
            ref.read(calendarEventProvider.notifier).updateDescription(value);
          },
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: UnderlineInputBorder(),
            hintText: 'コメントを入力してください',
          ),
          maxLines: 8,
        ),
      ),
    );
  }

  // 予定を削除するメソッド
  Widget deleteSchedule(List<CalendarEvent> todoItemList, CalendarEvent data) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        fixedSize: const Size(450, 50), //(横、高さ)
      ),
      onPressed: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: const Text('編集を破棄'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("予定の削除"),
                          content: const Text('本当にこの日の予定を削除しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "キャンセル",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final todoProvider =
                                    ref.watch(todoDatabaseProvider.notifier);
                                todoProvider.deleteData(data);

                                Navigator.popUntil(
                                    context, ModalRoute.withName("/"));
                              },
                              child: const Text('削除'),
                            ),
                          ],
                        );
                      },
                    ),
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('キャンセル'),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
              ),
            );
          },
        );
      },
      child: const Text('この予定を削除'),
    );
  }

  // 開始日と終了日を選択する際に用いるDatePickerを表示させるメソッド。
  Future<void> cupertinoDatePicker(Widget child) async {
    var state = ref.watch(calendarEventProvider);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 280,
        padding: const EdgeInsets.only(top: 6),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: () {
                      final isEndTimeBefore =
                          state.endDate.isBefore(state.startDate);
                      final isEqual = state.endDate.microsecondsSinceEpoch ==
                          state.startDate.millisecondsSinceEpoch;

                      if (state.isAllDay) {
                        if (isEndTimeBefore || isEqual) {
                          setState(() {
                            state = state.copyWith(endDate: state.startDate);
                          });
                        }
                      } else {
                        if (isEndTimeBefore || isEqual) {
                          setState(() {
                            state = state.copyWith(
                              endDate: state.startDate.add(
                                const Duration(hours: 1),
                              ),
                            );
                          });
                        }
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('完了'),
                  )
                ],
              ),
            ),
            Expanded(
              child: SafeArea(top: false, child: child),
            ),
          ],
        ),
      ),
    );
  }
}
