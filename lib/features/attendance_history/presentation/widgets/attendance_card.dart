import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/attendance_record.dart';
import 'status_chip.dart';
class AttendanceCard extends StatelessWidget {
  final AttendanceRecord record;
  const AttendanceCard({super.key, required this.record});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusChip(status: record.status),
                Text(
                  DateFormatter.toCardFormat(record.date),
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Container(
                height: 1,
                color: AppColors.surfaceVariant,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam In',
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.login,
                            size: 20,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            record.clockIn != null
                                ? DateFormatter.toTimeFormat(record.clockIn!)
                                : '--:--',
                            style: AppTextStyles.titleMd.copyWith(
                              color: record.isLate
                                  ? AppColors.error
                                  : AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Out',
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 20,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            record.clockOut != null
                                ? DateFormatter.toTimeFormat(record.clockOut!)
                                : '--:--',
                            style: AppTextStyles.titleMd.copyWith(
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Durasi Kerja',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    record.durationMinutes != null
                        ? DurationFormatter.fromMinutes(record.durationMinutes!)
                        : '--',
                    style: AppTextStyles.titleMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
