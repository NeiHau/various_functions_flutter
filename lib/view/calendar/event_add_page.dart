import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/repository/event_crud_provider.dart';
import 'package:calendar_app_remake/view/calendar/component/calendar_event_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../repository/calendar_event_state_provider.dart';

class EventAddingPage extends ConsumerStatefulWidget {
  const EventAddingPage({
    super.key,
    this.event,
    required this.currentDate,
  });

  final CalendarEvent? event;
  final DateTime currentDate;

  @override
  ConsumerState<EventAddingPage> createState() => EventAddingPageState();
}

class EventAddingPageState extends ConsumerState<EventAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Center(
          child: Text('予定の追加'),
        ),
        leading: const CloseButton(),
        actions: storeCalendarEvent(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              inputTitle(), // タイトルを入力
              const SizedBox(height: 25, width: 10), // 余白を生成する
              selectShujitsuDay(), // 開始日・終了日を選択
              inputDescription(), // コメントを入力
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを表示させるためのメソッド。
  List<Widget> storeCalendarEvent() {
    final state = ref.watch(calendarEventProvider);

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
        child: TextButton(
          onPressed: (state.title == '' || state.description == '')
              ? null
              : () {
                  TodoItemData data = TodoItemData(
                    id: state.id,
                    title: state.title,
                    description: state.description,
                    startDate: state.startDate,
                    endDate: state.endDate,
                    shujitsuBool: state.isAllDay,
                  );

                  //print(data);
                  // 'todoprovider'でProviderのメソッドや値を取得。
                  final todoProvider = ref.watch(todoDatabaseProvider.notifier);
                  todoProvider.writeData(data);

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
      ),
    ];
  }

  // タイトルに入力をするためのメソッド。
  Widget inputTitle() {
    var state = ref.watch(calendarEventProvider);

    return Card(
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
          child: TextFormField(
            textInputAction: TextInputAction.search,
            controller: _titleController,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis),
            decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: UnderlineInputBorder(),
                hintText: 'タイトルを入力してください'),
            onChanged: (value) {
              setState(() {
                state = state.copyWith(title: value);
              });
              ref.read(calendarEventProvider.notifier).updateTitle(value);
            },
          )),
    );
  }

  // 開始日、終了日を入力するためのメソッド。
  Widget selectShujitsuDay() {
    var now = DateTime.now();
    var state = ref.watch(calendarEventProvider);
    bool isCurrentDate = ref.watch(isCurrentDateAddProvider);

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
                    : isCurrentDate
                        ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())
                        : DateFormat('yyyy-MM-dd HH:mm')
                            .format(state.startDate),
              ),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: isCurrentDate
                      ? DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                        )
                      : DateTime(
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
                ));
              },
            ),
          ),
          ListTile(
            title: const Text('終了'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(state.isAllDay
                  ? DateFormat('yyyy-MM-dd').format(state.endDate)
                  : isCurrentDate
                      ? DateFormat('yyyy-MM-dd HH:mm').format(
                          DateTime.now().add(
                            const Duration(hours: 2),
                          ),
                        )
                      : DateFormat('yyyy-MM-dd HH:mm').format(state.endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: isCurrentDate
                      ? DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                        ).add(const Duration(hours: 2))
                      : DateTime(
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
                ));
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

  // コメントを入力
  Widget inputDescription() {
    var state = ref.watch(calendarEventProvider);

    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          controller: _descriptionController,
          onChanged: (value) {
            setState(() {
              state = state.copyWith(description: value);
            });
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
                      child: const Text('キャンセル')),
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
                      child: const Text('完了'))
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
