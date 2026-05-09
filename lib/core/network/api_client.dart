import 'package:dio/dio.dart';
import '../error/exceptions.dart';
class ApiClient {
  final Dio _dio;
  ApiClient({required String baseUrl, String? authToken})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (authToken != null && authToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $authToken';
          }
          handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) {
          print('🌐 $log');
        },
      ),
    );
  }
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  ServerException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(
          'Koneksi timeout. Coba lagi nanti.',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response?.data);
        return ServerException(message, statusCode: statusCode);
      case DioExceptionType.connectionError:
        return const ServerException(
          'Tidak bisa terhubung ke server.',
          statusCode: 0,
        );
      default:
        return ServerException(
          error.message ?? 'Terjadi kesalahan.',
        );
    }
  }
  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? 'Terjadi kesalahan pada server';
    }
    return 'Terjadi kesalahan pada server';
  }
}
