import 'package:employee_app/core/string_extension.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static final dateDisplayFormat = DateFormat('dd MMM yyyy');
  static final homeDateDisplayFormat = DateFormat('dd MMM, yyyy');
  static final monthDateFormat = DateFormat('MMMM yyyy');

  static DateTime findNextWeek() {
    DateTime now = DateTime.now();
    DateTime nextWeek = now.add(const Duration(days: 7));
    return nextWeek;
  }

  static DateTime findNextDay(int day) {
    DateTime now = DateTime.now();
    int daysUntilNextDay = day - now.weekday + 7;

    if (daysUntilNextDay == 0) {
      daysUntilNextDay += 7;
    }

    DateTime nextMonday = now.add(Duration(days: daysUntilNextDay));
    return nextMonday;
  }

  static displayDate(DateTime dateTime) {
    return dateDisplayFormat.format(dateTime);
  }

  static displayHomeDate(String date) {
    return homeDateDisplayFormat.format(dateDisplayFormat.parse(date));
  }

  static displayMonth(DateTime dateTime) {
    return monthDateFormat.format(dateTime).capitalize();
  }

  static isSameYearAndMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
}
