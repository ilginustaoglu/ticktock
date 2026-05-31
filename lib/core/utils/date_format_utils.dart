import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatDate(DateTime date, String locale) {
    return DateFormat.yMMMd(locale).format(date);
  }

  static String formatShortDate(DateTime date, String locale) {
    return DateFormat.MMMd(locale).format(date);
  }

  static String formatDateTime(DateTime date, String locale) {
    return DateFormat.yMMMd(locale).add_jm().format(date);
  }

  static String formatDayTitle(DateTime day, String locale) {
    return DateFormat.yMMMMd(locale).format(day);
  }
}
