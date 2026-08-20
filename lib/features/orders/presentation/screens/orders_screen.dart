import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_event.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_state.dart';
import 'package:fluid_boutique/features/orders/presentation/widgets/recent_order_card.dart';
import 'package:fluid_boutique/features/orders/presentation/widgets/active_order_card.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        buildWhen: (previous, current) =>
            current is OrdersLoadingState ||
            current is OrdersErrorState ||
            current is OrdersEmptyState ||
            current is OrdersSuccessState,
        builder: (context, state) {
          if (state is OrdersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is OrdersErrorState) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<OrdersBloc>().add(GetUserOrdersEvent()),
            );
          }

          if (state is OrdersEmptyState) {
            return _buildEmpty();
          }

          if (state is OrdersSuccessState) {
            return _buildContent(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ===== Main Content =====
  Widget _buildContent(BuildContext context, OrdersSuccessState state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Orders',
                  style: AppTextStyles.bold(
                    size: 26,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Track your luxury acquisitions and history.',
                  style: AppTextStyles.regular(
                    size: 13,
                    color: AppColors.textSecondary,
                    font: AppFont.inter,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Active Order
        if (state.activeOrder != null) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ActiveOrderCard(order: state.activeOrder!),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
        ],
        // Recent History Header
        if (state.recentOrders.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Recent History',
                style: AppTextStyles.bold(
                  size: 18,
                  color: AppColors.darkBlueIcon,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        ],
        // Recent Orders List
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              child: RecentOrderCard(order: state.recentOrders[index]),
            ),
            childCount: state.recentOrders.length,
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 32.h)),
      ],
    );
  }

  // ===== Empty =====
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 72.w,
            color: AppColors.dotsColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Orders Yet',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your order history will appear here.',
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
