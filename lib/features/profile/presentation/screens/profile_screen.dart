import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_event.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_state.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_state.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_event.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_state.dart';
import 'package:fluid_boutique/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:fluid_boutique/features/profile/presentation/widgets/profile_state_item.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:fluid_boutique/injection_container.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onGoToWishlist});
  final VoidCallback onGoToWishlist;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  void _showLogOutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Log Out',
          style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: AppTextStyles.regular(
            size: 14,
            color: AppColors.textSecondary,
            font: AppFont.inter,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: AppTextStyles.semibold(
                size: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileBloc>().add(LogOutEvent());
            },
            child: Text(
              'Log Out',
              style: AppTextStyles.semibold(size: 14, color: AppColors.sale),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          current is LogOutSuccessState || current is LogOutErrorState,
      listener: (context, state) {
        if (state is LogOutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
        if (state is LogOutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ProfileLoadingState ||
          current is ProfileErrorState ||
          current is ProfileSuccessState ||
          current is LogOutLoadingState,
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is ProfileErrorState) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () => context.read<ProfileBloc>().add(GetProfileEvent()),
          );
        }

        if (state is LogOutLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is ProfileSuccessState) {
          return _buildContent(context, state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ===== Main Content =====
  Widget _buildContent(BuildContext context, ProfileSuccessState state) {
    final profile = state.profile;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header =====
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.dotsColor,
                      backgroundImage: profile.photoUrl != null
                          ? NetworkImage(profile.photoUrl!)
                          : null,
                      child: profile.photoUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 36,
                              color: AppColors.textTertiary,
                            )
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: AppTextStyles.bold(
                    size: 18,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  profile.email,
                  style: AppTextStyles.regular(
                    size: 13,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== Stats Card =====
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Orders Count
                BlocBuilder<OrdersBloc, OrdersState>(
                  buildWhen: (previous, current) =>
                      current is OrdersSuccessState,
                  builder: (context, ordersState) {
                    int count = 0;
                    if (ordersState is OrdersSuccessState) {
                      count =
                          ordersState.recentOrders.length +
                          (ordersState.activeOrder != null ? 1 : 0);
                    }
                    return ProfileStateItem(value: '$count', label: 'ORDERS');
                  },
                ),
                Container(width: 1, height: 32, color: AppColors.dotsColor),
                // Wishlist Count
                BlocBuilder<WishlistBloc, WishlistState>(
                  buildWhen: (previous, current) =>
                      current is WishlistSuccessState,
                  builder: (context, wishlistState) {
                    int count = 0;
                    if (wishlistState is WishlistSuccessState) {
                      count = wishlistState.wishlist.length;
                    }
                    return ProfileStateItem(value: '$count', label: 'WISHLIST');
                  },
                ),
                Container(width: 1, height: 32, color: AppColors.dotsColor),
                // Points (static)
                const ProfileStateItem(value: '450', label: 'POINTS'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ===== Account Settings =====
          Text(
            'ACCOUNT SETTINGS',
            style: AppTextStyles.semibold(
              size: 11,
              color: AppColors.textTertiary,
              font: AppFont.inter,
            ),
          ),
          const SizedBox(height: 10),
          ProfileMenuTile(
            icon: Icons.receipt_long_outlined,
            title: 'My Orders',
            onTap: () => Navigator.pushNamed(context, AppRoutes.orders),
          ),
          ProfileMenuTile(
            icon: Icons.favorite_border_rounded,
            title: 'Wishlist',
            onTap: widget.onGoToWishlist,
          ),
          BlocProvider(
            create: (_) => sl<NotificationBloc>()..add(GetNotificationsEvent()),
            child: BlocBuilder<NotificationBloc, NotificationsState>(
              builder: (context, state) {
                final unreadCount = state is NotificationsSuccessState
                    ? state.unreadCount
                    : 0;

                return ProfileMenuTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  trailing: unreadCount > 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: AppColors.sale,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$unreadCount',
                            style: AppTextStyles.bold(
                              size: 11,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : null,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ===== Preference & Security =====
          Text(
            'PREFERENCE & SECURITY',
            style: AppTextStyles.semibold(
              size: 11,
              color: AppColors.textTertiary,
              font: AppFont.inter,
            ),
          ),
          const SizedBox(height: 10),
          ProfileMenuTile(
            icon: Icons.location_on_outlined,
            title: 'Shipping Addresses',
            onTap: () {},
          ),
          ProfileMenuTile(
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          // ===== Support =====
          Text(
            'SUPPORT',
            style: AppTextStyles.semibold(
              size: 11,
              color: AppColors.textTertiary,
              font: AppFont.inter,
            ),
          ),
          const SizedBox(height: 10),
          ProfileMenuTile(
            icon: Icons.headset_mic_outlined,
            title: 'Support',
            onTap: () {},
          ),
          ProfileMenuTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            isDanger: true,
            onTap: _showLogOutDialog,
          ),
        ],
      ),
    );
  }
}
