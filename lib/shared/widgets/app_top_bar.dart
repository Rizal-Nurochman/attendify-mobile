import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.appBarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: AppSpacing.avatarSize,
            height: AppSpacing.avatarSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 20,
                color: AppColors.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Attendance',
            style: AppTextStyles.titleLg.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.primary,
          ),
          tooltip: 'Notifications',
        ),
      ],
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.surfaceVariant,
        ),
      ),
    );
  }
}
