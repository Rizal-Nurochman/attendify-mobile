import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/scan_result.dart';
import '../repositories/scan_repository.dart';
class SubmitAttendance {
  final ScanRepository repository;
  const SubmitAttendance(this.repository);
  Future<Either<Failure, ScanResult>> call({required String qrData}) {
    return repository.submitAttendance(qrData: qrData);
  }
}
