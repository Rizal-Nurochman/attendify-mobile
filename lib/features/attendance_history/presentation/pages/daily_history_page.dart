import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
import '../widgets/attendance_card.dart';
import '../widgets/date_filter_bar.dart';
class DailyHistoryPage extends StatelessWidget {
  const DailyHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Daily History',
              style: AppTextStyles.titleMd.copyWith(
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            BlocBuilder<HistoryBloc, HistoryState>(
              buildWhen: (previous, current) =>
                  current is HistoryLoaded || current is HistoryInitial,
              builder: (context, state) {
                final selectedDate = state is HistoryLoaded
                    ? state.selectedDate
                    : DateTime.now();
                return DateFilterBar(
                  selectedDate: selectedDate,
                  onDateChanged: (date) {
                    context
                        .read<HistoryBloc>()
                        .add(FilterByDate(date: date));
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const LoadingIndicator(
                      message: 'Memuat riwayat...',
                    );
                  }
                  if (state is HistoryError) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: () {
                        context.read<HistoryBloc>().add(
                              LoadDailyHistory(date: DateTime.now()),
                            );
                      },
                    );
                  }
                  if (state is HistoryLoaded) {
                    if (state.records.isEmpty) {
                      return const _EmptyView();
                    }
                    return ListView.separated(
                      itemCount: state.records.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        return AttendanceCard(record: state.records[index]);
                      },
                    );
                  }
                  return const LoadingIndicator(
                    message: 'Memuat riwayat...',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}
class _EmptyView extends StatelessWidget {
  const _EmptyView();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history_toggle_off,
            size: 48,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Belum ada riwayat absensi\npada tanggal ini',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
