import 'package:calendar_app_remake/domain/calendar_event.dart';
import 'package:calendar_app_remake/view/calendar/calendar_page.dart';
import 'package:calendar_app_remake/view/calendar/component/calendar_event_dialog.dart';
import 'package:calendar_app_remake/view/calendar/component/calendar_event_list.dart';
import 'package:calendar_app_remake/view/calendar/event_add_page.dart';
import 'package:calendar_app_remake/view/calendar/event_edit_page.dart';
import 'package:calendar_app_remake/view/home/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/home';
  static const String calendarPage = '/calendarPage';
  static const String calendarEventList = '/EventList';
  static const String eventAddingPage = '/AddingPage';
  static const String eventEditingPage = '/EditingPage';
  static const String calendarListDialog = '/EventListDialog';

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
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
