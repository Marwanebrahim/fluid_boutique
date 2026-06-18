import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});
  final String title;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppColors.white.withValues(alpha: 0.8),
      actions: actions,
      elevation: 1,
      titleTextStyle: AppTextStyles.bold(
        size: 20,
        color: AppColors.navSelected,
      ),
      leading: Icon(Icons.list_rounded, color: AppColors.navSelected, size: 24),
    );
  }
}
