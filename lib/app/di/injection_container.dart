import 'package:get_it/get_it.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../../features/attendance_history/data/datasources/attendance_remote_data_source.dart';
import '../../features/attendance_history/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance_history/domain/repositories/attendance_repository.dart';
import '../../features/attendance_history/domain/usecases/get_daily_history.dart';
import '../../features/attendance_history/presentation/bloc/history_bloc.dart';
import '../../features/scan_qr/data/repositories/scan_repository_impl.dart';
import '../../features/scan_qr/domain/repositories/scan_repository.dart';
import '../../features/scan_qr/domain/usecases/submit_attendance.dart';
import '../../features/scan_qr/presentation/bloc/scan_bloc.dart';
final sl = GetIt.instance;
Future<void> initDependencies() async {
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetDailyHistory(sl()));
  sl.registerFactory(
    () => HistoryBloc(getDailyHistory: sl()),
  );
  sl.registerLazySingleton<ScanRepository>(
    () => ScanRepositoryImpl(apiClient: sl()),
  );
  sl.registerLazySingleton(() => SubmitAttendance(sl()));
  sl.registerFactory(
    () => ScanBloc(submitAttendance: sl()),
  );
}
