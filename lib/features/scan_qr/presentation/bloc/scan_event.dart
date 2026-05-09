import 'package:equatable/equatable.dart';
abstract class ScanEvent extends Equatable {
  const ScanEvent();
  @override
  List<Object?> get props => [];
}
class QrCodeDetected extends ScanEvent {
  final String qrData;
  const QrCodeDetected({required this.qrData});
  @override
  List<Object?> get props => [qrData];
}
class ResetScan extends ScanEvent {
  const ResetScan();
}
