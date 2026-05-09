import 'package:intl/intl.dart';
class DateFormatter {
  DateFormatter._();
  static String toSlashFormat(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  static String toCardFormat(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
  static String toTableFormat(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }
  static String toTimeFormat(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
  static String toTime24Format(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
class DurationFormatter {
  DurationFormatter._();
  static String fromMinutes(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours == 0) return '${minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }
  static String fromDuration(Duration duration) {
    return fromMinutes(duration.inMinutes);
  }
  static String calculate(DateTime clockIn, DateTime clockOut) {
    final duration = clockOut.difference(clockIn);
    return fromDuration(duration);
  }
}
