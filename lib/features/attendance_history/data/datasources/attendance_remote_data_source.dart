import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/attendance_record_model.dart';
abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceRecordModel>> getDailyHistory({required DateTime date});
  Future<List<AttendanceRecordModel>> getMonthlySummary({
    required int month,
    required int year,
  });
}
class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient apiClient;
  const AttendanceRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<AttendanceRecordModel>> getDailyHistory({
    required DateTime date,
  }) async {
    try {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final response = await apiClient.get(
        ApiConstants.dailyHistory,
        queryParameters: {'date': dateStr},
      );
      
      var data = response['data'];
      if (data is Map<String, dynamic> && data.containsKey('items')) {
        data = data['items'];
      }
      
      final listData = data as List<dynamic>;
      return listData
          .map((json) =>
              AttendanceRecordModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Gagal mengambil data riwayat: $e');
    }
  }
  @override
  Future<List<AttendanceRecordModel>> getMonthlySummary({
    required int month,
    required int year,
  }) async {
    try {
      final monthStr = '${year}-${month.toString().padLeft(2, '0')}';
      final response = await apiClient.get(
        ApiConstants.monthlyHistory,
        queryParameters: {
          'employeeCode': 'EMP-001',
          'month': monthStr,
        },
      );
      
      var data = response['data'];
      if (data is Map<String, dynamic> && data.containsKey('items')) {
        data = data['items'];
      }
      
      final listData = data as List<dynamic>;
      return listData
          .map((json) =>
              AttendanceRecordModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Gagal mengambil data bulanan: $e');
    }
  }
}
