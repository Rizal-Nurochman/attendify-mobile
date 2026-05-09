import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/submit_attendance.dart';
import 'scan_event.dart';
import 'scan_state.dart';
class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final SubmitAttendance submitAttendance;
  ScanBloc({required this.submitAttendance}) : super(const ScanIdle()) {
    on<QrCodeDetected>(_onQrCodeDetected);
    on<ResetScan>(_onResetScan);
  }
  Future<void> _onQrCodeDetected(
    QrCodeDetected event,
    Emitter<ScanState> emit,
  ) async {
    if (state is ScanProcessing || state is ScanSuccess || state is ScanFailureState) return;
    emit(const ScanProcessing());
    final result = await submitAttendance(qrData: event.qrData);
    result.fold(
      (failure) => emit(ScanFailureState(message: failure.message)),
      (scanResult) {
        if (scanResult.isSuccess) {
          emit(ScanSuccess(result: scanResult));
        } else {
          emit(ScanFailureState(
            message: scanResult.errorMessage ?? 'Scan gagal',
          ));
        }
      },
    );
  }
  void _onResetScan(ResetScan event, Emitter<ScanState> emit) {
    emit(const ScanIdle());
  }
}
