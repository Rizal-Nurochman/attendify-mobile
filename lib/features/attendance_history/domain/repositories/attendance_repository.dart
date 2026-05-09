import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_record.dart';
abstract class AttendanceRepository {
  Future<Either<Failure, List<AttendanceRecord>>> getDailyHistory({
    required DateTime date,
  });
  Future<Either<Failure, List<AttendanceRecord>>> getMonthlySummary({
    required int month,
    required int year,
  });
}
