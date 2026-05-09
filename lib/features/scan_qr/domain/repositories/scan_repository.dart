import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/scan_result.dart';
abstract class ScanRepository {
  Future<Either<Failure, ScanResult>> submitAttendance({
    required String qrData,
  });
}
