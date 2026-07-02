import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationTypeHelper {
  static IconData getIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.local_shipping_outlined;
      case 'promo':
        return Icons.local_offer_outlined;
      case 'exclusive':
        return Icons.diamond_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  static Color getColor(String type) {
    switch (type) {
      case 'order':
        return AppColors.primary;
      case 'promo':
        return AppColors.gold;
      case 'exclusive':
        return AppColors.sale;
      default:
        return AppColors.textTertiary;
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  static String getTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}
