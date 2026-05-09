class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
  @override
  String toString() => 'ServerException($statusCode): $message';
}
class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error']);
  @override
  String toString() => 'CacheException: $message';
}
class ScanException implements Exception {
  final String message;
  const ScanException([this.message = 'Scan error']);
  @override
  String toString() => 'ScanException: $message';
}
