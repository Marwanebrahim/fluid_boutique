import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';
import 'package:fluid_boutique/features/notification/presentation/widgets/notification_tile_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = NotificationTypeHelper.getColor(notification.type);
    final icon = NotificationTypeHelper.getIcon(notification.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.white
              : AppColors.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16.r),
          border: notification.isRead
              ? null
              : Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18.w, color: color),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.semibold(
                            size: 13,
                            color: AppColors.darkBlueIcon,
                          ),
                        ),
                      ),
                      Text(
                        NotificationTypeHelper.getTimeAgo(
                          notification.createdAt,
                        ),
                        style: AppTextStyles.regular(
                          size: 11,
                          color: AppColors.textTertiary,
                          font: AppFont.inter,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular(
                      size: 12,
                      color: AppColors.textSecondary,
                      font: AppFont.inter,
                    ),
                  ),
                ],
              ),
            ),

            // Unread dot
            if (!notification.isRead)
              Padding(
                padding: EdgeInsets.only(left: 8.w, top: 4.h),
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.sale,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
