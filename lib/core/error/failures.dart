import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
  @override
  List<Object> get props => [message, statusCode ?? 0];
}
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Tidak ada koneksi internet']);
}
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Gagal mengakses data lokal']);
}
class ScanFailure extends Failure {
  const ScanFailure([super.message = 'QR Code tidak terbaca']);
}
