import 'package:equatable/equatable.dart';
import '../../../../../../features/attendance_history/domain/entities/attendance_record.dart';

class ScanResult extends Equatable {
  final String action;
  final String message;
  final AttendanceRecord attendance;
  final List<AttendanceRecord> monthlyHistory;
  final bool isSuccess;
  final String? errorMessage;

  const ScanResult({
    required this.action,
    required this.message,
    required this.attendance,
    required this.monthlyHistory,
    required this.isSuccess,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [action, message, attendance, monthlyHistory, isSuccess, errorMessage];
}
