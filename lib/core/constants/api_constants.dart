class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://10.0.2.2:3000/api';

  static const String scan = '/attendance/scan';
  static const String dailyHistory = '/attendance/daily';
  static const String monthlyHistory = '/attendance/monthly';
}
class AppConstants {
  AppConstants._();
  static const String appName = 'Attendify';
  static const int workStartHour = 9;   // 09:00
  static const int workStartMinute = 0;
  static const int workEndHour = 17;    // 17:00
  static const int workEndMinute = 0;
}
