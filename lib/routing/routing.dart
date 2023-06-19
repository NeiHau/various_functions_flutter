import 'package:calendar_app_remake/View/calendar_page.dart';
import 'package:calendar_app_remake/View/component/calendar_event_dialog.dart';
import 'package:calendar_app_remake/View/event_add_page.dart';
import 'package:calendar_app_remake/View/event_edit_page.dart';
import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:flutter/material.dart';

import '../View/component/calendar_event_list.dart';

class RouteGenerator {
  static const String calendarPage = '/home';
  static const String calendarEventList = '/EventList';
  static const String eventAddingPage = '/AddingPage';
  static const String eventEditingPage = '/EditingPage';
  static const String calendarListDialog = '/EventListDialog';

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case calendarPage:
        return MaterialPageRoute(
          builder: (context) => const CalendarPage(),
        );
      case calendarEventList:
        return MaterialPageRoute(
            builder: (context) =>
                CalendarEventListView(currentDate: DateTime.now()));
      case eventAddingPage:
        final currentDate = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (context) => EventAddingPage(currentDate: currentDate));
      case eventEditingPage:
        final arguments = settings.arguments as CalendarEvent;
        return MaterialPageRoute(
            builder: (context) => EventEditingPage(arguments: arguments));
      case calendarListDialog:
        return MaterialPageRoute(
            builder: (context) =>
                CalendarListDialog(cacheDate: DateTime.now()));
      default:
        throw Exception('Route not found');
    }
  }
}
