import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_record.dart';
import '../repositories/attendance_repository.dart';
class GetDailyHistory {
  final AttendanceRepository repository;
  const GetDailyHistory(this.repository);
  Future<Either<Failure, List<AttendanceRecord>>> call({
    required DateTime date,
  }) {
    return repository.getDailyHistory(date: date);
  }
}
