import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/attendance_record.dart';
class StatusChip extends StatelessWidget {
  final AttendanceStatus status;
  const StatusChip({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    final isOnTime = status == AttendanceStatus.onTime;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isOnTime ? AppColors.primaryFixed : AppColors.errorContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOnTime ? Icons.check_circle : Icons.schedule,
            size: 16,
            color: isOnTime ? AppColors.primary : AppColors.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            isOnTime ? 'TEPAT WAKTU' : 'TERLAMBAT',
            style: AppTextStyles.labelLg.copyWith(
              color: isOnTime
                  ? AppColors.onPrimaryFixedVariant
                  : AppColors.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}
