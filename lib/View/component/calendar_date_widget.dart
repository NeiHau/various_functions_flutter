import 'package:calendar_app_remake/View/component/calendar_event_dialog.dart';
import 'package:calendar_app_remake/repository/event_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

final weekDayProvider = StateProvider(((ref) => 7));
final foucusedDayProvider = StateProvider(((ref) => DateTime.now()));

class CalendarDateWidget extends ConsumerStatefulWidget {
  const CalendarDateWidget(
      {required this.calendarController,
      this.color,
      this.now,
      this.weekDay,
      Key? key})
      : super(key: key);

  final Color? color;
  final DateTime? now;
  final DateTime? weekDay;
  final PageController calendarController;

  @override
  ConsumerState<CalendarDateWidget> createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarDateWidget> {
  final List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
  late DateTime selectedDate;
  final int _monthDuration = 0;
  final firstDay = DateTime(1970);
  late int prevPage;

  @override
  void initState() {
    final eventState = ref.read(eventStateProvider.notifier);
    eventState.readDataMap();

    selectedDate = ref.read(foucusedDayProvider.notifier).state;
    final initialPageCount = getPageCount(firstDay, selectedDate);
    prevPage = initialPageCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentMonth(ref),
        dayOfWeek(ref),
        const SizedBox(height: 10),
        Expanded(child: createCalendar(ref)),
      ],
    );
  }

  // 今月のカレンダー画面で表示させたい機能('今日ボタン','年月','MonthYearPicker')を含むメソッド
  Container currentMonth(WidgetRef ref) {
    return Container(
      color: Colors.white,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder()),
                onPressed: () {
                  widget.calendarController.animateToPage(
                      widget.calendarController.initialPage,
                      duration: const Duration(milliseconds: 2),
                      curve: Curves.ease);
                  setState(() {
                    selectedDate = DateTime.now();
                  });
                },
                child: const Text('今日')),
          ),
          Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 13, 5),
              child: Text(
                  DateFormat('yyyy年M月').format(DateTime(
                      ref.read(foucusedDayProvider).year,
                      ref.read(foucusedDayProvider).month + _monthDuration,
                      1)),
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 65, 5),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                selectDate('ja');
              },
            )
          ]),
          const SizedBox(),
        ],
      ),
    );
  }

  // カレンダーの曜日を表示させるメソッド
  Widget dayOfWeek(WidgetRef ref) {
    List<Widget> weekList = [];
    int weekIndex = ref.read(weekDayProvider); //初期値
    int counter = 0;
    while (counter < 7) {
      weekList.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _weekName[weekIndex % 7],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0, color: _textWeekDayColor(weekIndex)),
              ),
            ),
          ),
        ),
      );
      weekIndex++;
      counter++;
    }
    return Row(
      children: weekList,
    );
  }

  // カレンダーの日にちを作成するメソッド
  Widget createCalendar(WidgetRef ref) {
    final dataMap = ref.watch(eventStateProvider).todoItemsMap;
    List<Widget> list = []; // カレンダーの日数全てを含むリスト。1日〜月の最終日まで。

    // 月の最初の日。
    DateTime firstDayOfTheMonth = DateTime(ref.watch(foucusedDayProvider).year,
        ref.watch(foucusedDayProvider).month + _monthDuration, 1);
    // 月の最終日。
    int monthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1)
            .add(const Duration(days: -1))
            .day;
    // 今月のカレンダーの第一週の空いている部分を埋める際に用いる、前月の最後の週の日にちを求める変数。
    int previousMonthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, 1)
            .add(const Duration(days: -1))
            .day;
    // 今月のカレンダーの最後の週の空いている部分を埋める際に用いる、来月の第一週目の日にちを求める変数。
    int nextMonthFirstNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1).day;
    List<Widget> listCache = []; // 月〜日までの日にちをまとめたリスト。

    for (int i = 1; i <= monthLastNumber; i++) {
      listCache.add(
        Expanded(
          child: Column(
            children: [
              buildCalendarItem(
                  i,
                  DateTime(
                      firstDayOfTheMonth.year, firstDayOfTheMonth.month, i),
                  ref),
              (dataMap.containsKey(DateTime(firstDayOfTheMonth.year,
                      firstDayOfTheMonth.month, i))) // 予定が追加されたら点を表示させる。
                  ? const Icon(Icons.brightness_1, color: Colors.black, size: 6)
                  : const SizedBox(height: 0, width: 0),
            ],
          ),
        ),
      );
      if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .weekday ==
              newLineNumber(ref.read(weekDayProvider) + 1) ||
          i == monthLastNumber) {
        int repeatNumber = 7 - listCache.length;

        for (int j = 0; j < repeatNumber; j++) {
          if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .day <=
              7) {
            listCache.insert(
              0,
              Expanded(
                child: Column(
                  children: [
                    buildCalendarItem(
                        previousMonthLastNumber - j,
                        DateTime(
                            firstDayOfTheMonth.year,
                            firstDayOfTheMonth.month - 1,
                            previousMonthLastNumber - j),
                        ref),
                    (dataMap.containsKey(DateTime(
                            firstDayOfTheMonth.year,
                            firstDayOfTheMonth.month - 1,
                            previousMonthLastNumber - j))) // 予定が追加されたら点を表示させる。
                        ? const Icon(Icons.brightness_1,
                            color: Colors.black, size: 6)
                        : const SizedBox(height: 0, width: 0)
                  ],
                ),
              ),
            );
          } else {
            listCache.add(
              Expanded(
                child: Column(
                  children: [
                    buildCalendarItem(
                        nextMonthFirstNumber + j,
                        DateTime(
                            firstDayOfTheMonth.year,
                            firstDayOfTheMonth.month + 1,
                            nextMonthFirstNumber + j),
                        ref),
                    (dataMap.containsKey(DateTime(
                            firstDayOfTheMonth.year,
                            firstDayOfTheMonth.month + 1,
                            nextMonthFirstNumber + j))) // 予定が追加されたら点を表示させる。
                        ? const Icon(Icons.brightness_1,
                            color: Colors.black, size: 6)
                        : const SizedBox(height: 0, width: 0),
                  ],
                ),
              ),
            );
          }
        }
        list.add(Column(
          children: [
            Row(
              children: listCache,
            ),
            const SizedBox(height: 10),
          ],
        ));
        listCache = [];
      }
    }
    return Column(
      children: list,
    );
  }

  // 次の週に移行する際に用いるメソッド。例: 第一週目 → 第二週目。
  int newLineNumber(int startNumber) {
    if (startNumber == 1) return 7;
    return startNumber - 1;
  }

  // 1. 今日を青い丸で囲む。
  // 2. 日付をタップした際に予定を追加する画面に移行する。
  // 上記の二点を以下のメソッド内で行う。
  Widget buildCalendarItem(int i, DateTime cacheDate, WidgetRef ref) {
    final focusedDay = ref.read(foucusedDayProvider);
    final date = DateTime.now();
    final today = DateTime(date.year, date.month, date.day);
    bool isToday = cacheDate == today && focusedDay.month == cacheDate.month;
    bool isOutsideDay = (focusedDay.month != cacheDate.month);

    if (isToday) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: GestureDetector(
            onTap: () {
              createTask(cacheDate);
            },
            child: Text(
              '$i',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  color: (isToday) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    if (isOutsideDay) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: GestureDetector(
            onTap: () {
              createTask(cacheDate);
            },
            child: Text(
              '$i',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blueGrey[100],
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      child: Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          child: Text(
            '$i',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: _textDayColor(cacheDate),
            ),
          ),
        ),
      ),
      onTap: () {
        createTask(cacheDate);
      },
    );
  }

  // 「土」と「日」の色を変更するメソッド。「土」は青、「日」は赤。
  Color _textDayColor(DateTime day) {
    const defaultTextColor = Colors.black87;

    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  // カレンダーの日付が土曜日なら青色、日曜日なら赤色に変更するメソッド。
  Color _textWeekDayColor(int weekIndex) {
    const defaultTextColor = Colors.black87;

    if (weekIndex == 13) {
      return Colors.red;
    }
    if (weekIndex == 12) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  // MonthYearPickerを表示させるメソッド。
  Future<void> selectDate(String? locale) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: ref.read(foucusedDayProvider.notifier).state,
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime(DateTime.now().year + 100),
      locale: localeObj,
      initialMonthYearPickerMode: MonthYearPickerMode.month,
      builder: (context, child) {
        return Center(
          child: Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.1,
              height: MediaQuery.of(context).size.height * 0.75,
              child: child,
            ),
          ),
        );
      },
    );

    if (selectedDate == null) return;

    // 選択した日付がカレンダーの何ページ目にあるか
    final initialPageCount = (selectedDate.year - firstDay.year) * 12 +
        selectedDate.month -
        firstDay.month;
    // 表示したいページをcalendarControllerに指示
    widget.calendarController.animateToPage(initialPageCount,
        duration: const Duration(milliseconds: 2), curve: Curves.ease);
  }

  // 日付をタップした際に表示させる予定追加画面のメソッド。
  void createTask(DateTime cacheDate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CalendarListDialog(cacheDate: cacheDate);
        });
  }
}
