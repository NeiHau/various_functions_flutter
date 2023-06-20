import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/repository/event_crud_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EventEditingPage extends ConsumerStatefulWidget {
  const EventEditingPage({super.key, required this.arguments});

  // 追加画面から引き継いだデータ。
  final CalendarEvent arguments;

  @override
  ConsumerState<EventEditingPage> createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isAllDay = false;
  static var uuid = const Uuid(); // idを取得
  late CalendarEvent temp;

  @override
  void initState() {
    temp = widget.arguments;
    super.initState();
  }

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
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              sizedBox(),
              selectShujitsuDay(),
              buildDescription(),
              sizedBox(),
              deleteSchedule(todoItems, widget.arguments),
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを作成するメソッド
  List<Widget> buildEditingActions() => [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          child: TextButton(
            onPressed: () {
              TodoItemData data = TodoItemData(
                id: temp.id,
                title: temp.title,
                description: temp.description,
                startDate: temp.startDate,
                endDate: temp.endDate,
                shujitsuBool: temp.isAllDay,
              );

              // 'todoprovider'でProviderのメソッドや値を取得。
              final todoProvider = ref.watch(todoDatabaseProvider.notifier);
              todoProvider.updateData(data);

              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        )
      ];

  // タイトルを入力するメソッド
  Widget buildTitle() => Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
          child: TextFormField(
            initialValue: temp.title,
            onChanged: (value) {
              temp = temp.copyWith(title: value);
            },
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis),
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: UnderlineInputBorder(),
              hintText: 'タイトルを入力してください',
            ),
          ),
        ),
      );

  // 開始日と終了日を選択するメソッド
  Widget selectShujitsuDay() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('終日'),
            trailing: createSwitch(0),
          ),
          ListTile(
            title: const Text('開始'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(
                temp.isAllDay
                    ? DateFormat('yyyy-MM-dd').format(temp.startDate)
                    : DateFormat('yyyy-MM-dd HH:mm').format(temp.startDate),
              ),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: DateTime(
                    temp.startDate.year,
                    temp.startDate.month,
                    temp.startDate.day,
                    temp.startDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(startDate: value);
                    setState(() {
                      startDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: temp.isAllDay
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
              child: Text(temp.isAllDay
                  ? DateFormat('yyyy-MM-dd').format(temp.endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(temp.endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: DateTime(
                    temp.endDate.year,
                    temp.endDate.month,
                    temp.endDate.day,
                    temp.endDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(endDate: value);
                    setState(() {
                      endDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: temp.isAllDay
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
  Switch createSwitch(int index) {
    return Switch(
      value: temp.isAllDay,
      onChanged: (value) {
        setState(() {
          temp = temp.copyWith(isAllDay: value);
        });
      },
    );
  }

  // コメント入力するフォームを作成するメソッド
  Widget buildDescription() {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          initialValue: temp.description,
          onChanged: (value) {
            temp = temp.copyWith(description: value);
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
                                  temp.endDate.isBefore(temp.startDate);
                              final isEqual =
                                  temp.endDate.microsecondsSinceEpoch ==
                                      temp.startDate.millisecondsSinceEpoch;

                              if (temp.isAllDay) {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    temp =
                                        temp.copyWith(endDate: temp.startDate);
                                  });
                                }
                              } else {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    temp = temp.copyWith(
                                        endDate: temp.startDate
                                            .add(const Duration(hours: 1)));
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('完了'))
                      ],
                    ),
                  ),
                  Expanded(child: SafeArea(top: false, child: child)),
                ],
              ),
            ));
  }

  // 余白を作りたい時に用いるメソッド
  Widget sizedBox() {
    return const SizedBox(
      height: 25,
      width: 10,
    );
  }
}
