import 'package:calendar_app_remake/database/todo_item_data_crud.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/repository/event_crud_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  final titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isAllDay = false;
  static var uuid = const Uuid(); // idを取得
  CalendarEvent temp = CalendarEvent(
      id: uuid.v1(),
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      title: '',
      description: '',
      isAllDay: false); //frezzedで格納した値をインスタンス化

  @override
  void initState() {
    startDate = widget.currentDate;
    endDate = startDate.add(const Duration(hours: 2));
    temp = temp.copyWith(startDate: startDate, endDate: endDate);

    super.initState();
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
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(), // タイトルを入力
              sizedBox(), // 余白を生成する
              selectShujitsuDay(), // 開始日・終了日を選択
              buildDescription(), // コメントを入力
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを表示させるためのメソッド。
  List<Widget> buildEditingActions() => [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          child: TextButton(
            onPressed: (temp.title == '' || temp.description == '')
                ? null
                : () {
                    TodoItemData data = TodoItemData(
                      id: temp.id,
                      title: temp.title,
                      description: temp.description,
                      startDate: temp.startDate,
                      endDate: temp.endDate,
                      shujitsuBool: temp.isAllDay,
                    );

                    //print(data);
                    // 'todoprovider'でProviderのメソッドや値を取得。
                    final todoProvider =
                        ref.watch(todoDatabaseProvider.notifier);
                    todoProvider.writeData(data);

                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        ),
      ];

  // タイトルに入力をするためのメソッド。
  Widget buildTitle() => Card(
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  temp = temp.copyWith(title: value);
                });
              },
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis),
              decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: UnderlineInputBorder(),
                  hintText: 'タイトルを入力してください'),
            )),
      );

  // 開始日、終了日を入力するためのメソッド。
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
              child: Text(isAllDay
                  ? DateFormat('yyyy-MM-dd').format(startDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(startDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: DateTime(
                    startDate.year,
                    startDate.month,
                    startDate.day,
                    startDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(startDate: value);
                    setState(() {
                      startDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: isAllDay
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
              child: Text(isAllDay
                  ? DateFormat('yyyy-MM-dd').format(endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(endDate: value);
                    setState(() {
                      endDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: isAllDay
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
        temp = temp.copyWith(isAllDay: value);
        setState(() {
          isAllDay = value;
        });
      },
    );
  }

  // コメントを入力
  Widget buildDescription() {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              temp = temp.copyWith(description: value);
            });
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
                                  endDate.isBefore(startDate);
                              final isEqual = endDate.microsecondsSinceEpoch ==
                                  startDate.millisecondsSinceEpoch;

                              if (isAllDay) {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    endDate = startDate;
                                    temp = temp.copyWith(endDate: startDate);
                                  });
                                }
                              } else {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    temp = temp.copyWith(
                                        endDate: startDate
                                            .add(const Duration(hours: 1)));
                                    endDate =
                                        startDate.add(const Duration(hours: 1));
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

  // 余白を作るためのメソッド。
  Widget sizedBox() {
    return const SizedBox(height: 25, width: 10);
  }
}
