import '../../domain/entities/attendance_record.dart';
class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel({
    required super.id,
    required super.date,
    super.clockIn,
    super.clockOut,
    super.durationMinutes,
    required super.status,
  });
  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    final dateStr = (json['tanggal'] ?? json['date']) as String;
    final date = DateTime.parse(dateStr);

    DateTime? clockIn;
    final clockInStr = (json['jamAbsensiIn'] ?? json['clock_in']) as String?;
    if (clockInStr != null) {
      clockIn = _parseTime(clockInStr, date);
    }

    DateTime? clockOut;
    final clockOutStr = (json['jamAbsensiOut'] ?? json['clock_out']) as String?;
    if (clockOutStr != null) {
      clockOut = _parseTime(clockOutStr, date);
    }

    int? durationMinutes;
    if (json['totalJamKerja'] != null) {
      durationMinutes = _parseDurationString(json['totalJamKerja'] as String);
    } else if (json['duration_minutes'] != null) {
      durationMinutes = json['duration_minutes'] as int;
    }

    final id = json['id'] as String? ?? 'auto-${date.millisecondsSinceEpoch}';
    final statusStr = json['status'] as String?;

    return AttendanceRecordModel(
      id: id,
      date: date,
      clockIn: clockIn,
      clockOut: clockOut,
      durationMinutes: durationMinutes,
      status: _parseStatus(statusStr),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      'jamAbsensiIn': clockIn != null
          ? '${clockIn!.hour.toString().padLeft(2, '0')}:${clockIn!.minute.toString().padLeft(2, '0')}:00'
          : null,
      'jamAbsensiOut': clockOut != null
          ? '${clockOut!.hour.toString().padLeft(2, '0')}:${clockOut!.minute.toString().padLeft(2, '0')}:00'
          : null,
      'totalJamKerja': durationMinutes != null
          ? '${(durationMinutes! ~/ 60).toString().padLeft(2, '0')}:${(durationMinutes! % 60).toString().padLeft(2, '0')}'
          : null,
      'status': status == AttendanceStatus.onTime ? 'on_time' : 'late',
    };
  }

  static DateTime _parseTime(String timeStr, DateTime date) {
    if (timeStr.contains('T') || timeStr.contains('-')) {
      return DateTime.parse(timeStr);
    }
    final parts = timeStr.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  static int _parseDurationString(String durationStr) {
    try {
      final parts = durationStr.split(':');
      if (parts.length >= 2) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        return (hours * 60) + minutes;
      }
    } catch (_) {}
    return 0;
  }

  static AttendanceStatus _parseStatus(String? status) {
    if (status == 'late') return AttendanceStatus.late;
    return AttendanceStatus.onTime;
  }
}
