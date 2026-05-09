import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  const AttendanceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<AttendanceRecord>>> getDailyHistory({
    required DateTime date,
  }) async {
    try {
      final records = await remoteDataSource.getDailyHistory(date: date);
      return Right(records); // Sukses → Right
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode)); // Error → Left
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan: $e'));
    }
  }
  @override
  Future<Either<Failure, List<AttendanceRecord>>> getMonthlySummary({
    required int month,
    required int year,
  }) async {
    try {
      final records = await remoteDataSource.getMonthlySummary(
        month: month,
        year: year,
      );
      return Right(records);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan: $e'));
    }
  }
}
