import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/scan_result.dart';
import '../../domain/repositories/scan_repository.dart';
import '../../../attendance_history/data/models/attendance_record_model.dart';
class ScanRepositoryImpl implements ScanRepository {
  final ApiClient apiClient;
  const ScanRepositoryImpl({required this.apiClient});
  @override
  Future<Either<Failure, ScanResult>> submitAttendance({
    required String qrData,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.scan,
        data: {
          'employeeCode': 'EMP-001',
          'qrCode': qrData,
        },
      );
      
      final isSuccess = response['status'] == 'success';
      if (!isSuccess) {
        return Left(ScanFailure(response['message'] as String? ?? 'Gagal melakukan absensi'));
      }

      final data = response['data'] as Map<String, dynamic>;
      final action = data['action'] as String? ?? 'UNKNOWN';
      final message = data['message'] as String? ?? 'Berhasil';
      
      final attendanceData = data['attendance'] as Map<String, dynamic>;
      final attendance = AttendanceRecordModel.fromJson(attendanceData);

      final monthlyHistoryData = data['monthlyHistory'] as Map<String, dynamic>?;
      final items = (monthlyHistoryData?['items'] as List<dynamic>?) ?? [];
      final monthlyHistory = items
          .map((item) => AttendanceRecordModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(ScanResult(
        action: action,
        message: message,
        attendance: attendance,
        monthlyHistory: monthlyHistory,
        isSuccess: true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ScanFailure('QR Code tidak terbaca. Pastikan pencahayaan cukup.'));
    }
  }
}
