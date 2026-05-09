import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_daily_history.dart';
import 'history_event.dart';
import 'history_state.dart';
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetDailyHistory getDailyHistory;
  HistoryBloc({required this.getDailyHistory})
      : super(const HistoryInitial()) {
    on<LoadDailyHistory>(_onLoadDailyHistory);
    on<FilterByDate>(_onFilterByDate);
  }
  Future<void> _onLoadDailyHistory(
    LoadDailyHistory event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const HistoryLoading());
    final result = await getDailyHistory(date: event.date);
    result.fold(
      (failure) => emit(HistoryError(message: failure.message)),
      (records) => emit(HistoryLoaded(
        records: records,
        selectedDate: event.date,
      )),
    );
  }
  Future<void> _onFilterByDate(
    FilterByDate event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const HistoryLoading());
    final result = await getDailyHistory(date: event.date);
    result.fold(
      (failure) => emit(HistoryError(message: failure.message)),
      (records) => emit(HistoryLoaded(
        records: records,
        selectedDate: event.date,
      )),
    );
  }
}
