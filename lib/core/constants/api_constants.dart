class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://attendify.lemonee.my.id';

  static const String scan = '/api/attendance/scan';
  static const String dailyHistory = '/api/attendance/daily';
  static const String monthlyHistory = '/api/attendance/monthly';
}
class AppConstants {
  AppConstants._();
  static const String appName = 'Attendify';
  static const int workStartHour = 9;   // 09:00
  static const int workStartMinute = 0;
  static const int workEndHour = 17;    // 17:00
  static const int workEndMinute = 0;
}
