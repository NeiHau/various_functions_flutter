import 'package:calendar_app_remake/View/component/calendar_event_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final isCurrentDateAddProvider = StateProvider((ref) => false);

class CalendarListDialog extends ConsumerWidget {
  const CalendarListDialog({super.key, required this.cacheDate});

  final DateTime cacheDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstDay = DateTime(1970);
    final PageController controller;
    final initialPage = getPageCount(firstDay, cacheDate);
    controller =
        PageController(initialPage: initialPage, viewportFraction: 0.85);
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.71,
        child: PageView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            DateTime currentDate =
                getCurrentDate(initialPage, index, cacheDate);
            return AlertDialog(
              insetPadding: const EdgeInsets.all(8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              title: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('yyyy/MM/dd (EEE)', 'ja').format(
                          DateTime(currentDate.year, currentDate.month,
                              currentDate.day),
                        ),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      IconButton(
                          onPressed: () {
                            if (currentDate.day == DateTime.now().day) {
                              ref
                                  .read(isCurrentDateAddProvider.notifier)
                                  .state = true;
                            } else {
                              ref
                                  .read(isCurrentDateAddProvider.notifier)
                                  .state = false;
                            }

                            Navigator.pushNamed(context, "/AddingPage",
                                arguments: currentDate);
                          },
                          icon: const Icon(Icons.add, color: Colors.blue)),
                    ]),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CalendarEventListView(currentDate: currentDate),
              ),
            );
          },
        ),
      ),
    ]);
  }
}

// 現在の日付から、指定されている日付(1970年1月)まで、どのくらいの月数があるかを計算するメソッド。
int getPageCount(DateTime firstDate, DateTime selectedDate) {
  return selectedDate.difference(firstDate).inDays;
}

// 選択された日付が、今日からどれくらい離れているかを計算するメソッド。
DateTime getCurrentDate(int initial, int page, DateTime cacheDate) {
  final distance = initial - page;
  return DateTime(cacheDate.year, cacheDate.month, cacheDate.day - distance);
}
