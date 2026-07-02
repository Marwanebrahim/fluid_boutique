import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_event.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_state.dart';
import 'package:fluid_boutique/features/notification/presentation/widgets/notification_tile_helper.dart';
import 'package:fluid_boutique/features/notification/presentation/widgets/notification_tile.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Fluid Boutique',
          style: AppTextStyles.bold(size: 16, color: AppColors.darkBlueIcon),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<NotificationBloc, NotificationsState>(
            buildWhen: (previous, current) =>
                current is NotificationsSuccessState,
            builder: (context, state) {
              final hasUnread =
                  state is NotificationsSuccessState && state.unreadCount > 0;
              if (!hasUnread) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: GestureDetector(
                  onTap: () => context.read<NotificationBloc>().add(
                    MarkAllAsReadEvent(),
                  ),
                  child: Text(
                    'Mark all as read',
                    style: AppTextStyles.semibold(
                      size: 12,
                      color: AppColors.primary,
                      font: AppFont.inter,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationsState>(
        buildWhen: (previous, current) =>
            current is NotificationsErrorState ||
            current is NotificationsEmptyState ||
            current is NotificationsSuccessState,
        builder: (context, state) {
          if (state is NotificationsErrorState) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<NotificationBloc>().add(GetNotificationsEvent()),
            );
          }

          if (state is NotificationsEmptyState) {
            return _buildEmpty();
          }

          if (state is NotificationsSuccessState) {
            return _buildContent(context, state.notifications);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<NotificationEntity> notifications,
  ) {
    final today = notifications
        .where((n) => NotificationTypeHelper.isToday(n.createdAt))
        .toList();
    final yesterday = notifications
        .where((n) => NotificationTypeHelper.isYesterday(n.createdAt))
        .toList();
    final earlier = notifications
        .where(
          (n) =>
              !NotificationTypeHelper.isToday(n.createdAt) &&
              !NotificationTypeHelper.isYesterday(n.createdAt),
        )
        .toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      children: [
        if (today.isNotEmpty) ...[
          _sectionHeader('TODAY'),
          ...today.map(
            (n) => NotificationTile(
              notification: n,
              onTap: () => _onTileTap(context, n),
            ),
          ),
        ],
        if (yesterday.isNotEmpty) ...[
          SizedBox(height: 8.h),
          _sectionHeader('YESTERDAY'),
          ...yesterday.map(
            (n) => NotificationTile(
              notification: n,
              onTap: () => _onTileTap(context, n),
            ),
          ),
        ],
        if (earlier.isNotEmpty) ...[
          SizedBox(height: 8.h),
          _sectionHeader('EARLIER'),
          ...earlier.map(
            (n) => NotificationTile(
              notification: n,
              onTap: () => _onTileTap(context, n),
            ),
          ),
        ],
      ],
    );
  }

  void _onTileTap(BuildContext context, NotificationEntity notification) {
    if (!notification.isRead) {
      context.read<NotificationBloc>().add(
        MarkAsReadEvent(notificationId: notification.id),
      );
    }
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        title,
        style: AppTextStyles.semibold(
          size: 11,
          color: AppColors.textTertiary,
          font: AppFont.inter,
        ),
      ),
    );
  }

  // ===== Empty =====
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 72.w,
            color: AppColors.dotsColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Notifications Yet',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          SizedBox(height: 8.h),
          Text(
            'Updates about your orders and offers\nwill appear here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.regular(
              size: 14,
              color: AppColors.textSecondary,
              font: AppFont.inter,
            ),
          ),
        ],
      ),
    );
  }
}
