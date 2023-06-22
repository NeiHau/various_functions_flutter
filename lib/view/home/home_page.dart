import 'package:calendar_app_remake/common/bottom_nav_bar_widget.dart';
import 'package:calendar_app_remake/repository/menu_item_repopsitory.dart';
import 'package:calendar_app_remake/view/calendar/calendar_page.dart';
import 'package:calendar_app_remake/view/home/home_page_widget.dart';
import 'package:calendar_app_remake/view/search/search_page.dart';
import 'package:calendar_app_remake/view/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  // Changed StatefulWidget to ConsumerWidget
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref
        .watch(selectedIndexProvider); // get the selected index from provider

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          HomePageContent(),
          SearchPage(),
          CalendarPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
