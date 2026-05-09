import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_record.dart';
abstract class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object?> get props => [];
}
class HistoryInitial extends HistoryState {
  const HistoryInitial();
}
class HistoryLoading extends HistoryState {
  const HistoryLoading();
}
class HistoryLoaded extends HistoryState {
  final List<AttendanceRecord> records;
  final DateTime selectedDate;
  const HistoryLoaded({
    required this.records,
    required this.selectedDate,
  });
  @override
  List<Object?> get props => [records, selectedDate];
}
class HistoryError extends HistoryState {
  final String message;
  const HistoryError({required this.message});
  @override
  List<Object?> get props => [message];
}
