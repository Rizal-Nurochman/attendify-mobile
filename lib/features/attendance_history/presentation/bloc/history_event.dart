import 'package:equatable/equatable.dart';
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}
class LoadDailyHistory extends HistoryEvent {
  final DateTime date;
  const LoadDailyHistory({required this.date});
  @override
  List<Object?> get props => [date];
}
class FilterByDate extends HistoryEvent {
  final DateTime date;
  const FilterByDate({required this.date});
  @override
  List<Object?> get props => [date];
}
