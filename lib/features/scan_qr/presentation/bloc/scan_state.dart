import 'package:equatable/equatable.dart';
import '../../domain/entities/scan_result.dart';
abstract class ScanState extends Equatable {
  const ScanState();
  @override
  List<Object?> get props => [];
}
class ScanIdle extends ScanState {
  const ScanIdle();
}
class ScanProcessing extends ScanState {
  const ScanProcessing();
}
class ScanSuccess extends ScanState {
  final ScanResult result;
  const ScanSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}
class ScanFailureState extends ScanState {
  final String message;
  const ScanFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}
