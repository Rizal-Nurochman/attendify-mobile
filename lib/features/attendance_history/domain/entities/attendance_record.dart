import 'package:equatable/equatable.dart';
enum AttendanceStatus {
  onTime,  // Tepat waktu
  late,    // Terlambat
}
class AttendanceRecord extends Equatable {
  final String id;
  final DateTime date;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final int? durationMinutes; // Total durasi kerja dalam menit
  final AttendanceStatus status;
  const AttendanceRecord({
    required this.id,
    required this.date,
    this.clockIn,
    this.clockOut,
    this.durationMinutes,
    required this.status,
  });
  bool get hasClockOut => clockOut != null;
  bool get isLate => status == AttendanceStatus.late;
  @override
  List<Object?> get props => [id, date, clockIn, clockOut, durationMinutes, status];
}
