import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/core/routing/args/checkout_args.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_event.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_state.dart';
import 'package:fluid_boutique/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is CartErrorState) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () => context.read<CartBloc>().add(GetCartEvent()),
          );
        }

        if (state is CartEmptyState) {
          return _buildEmpty();
        }

        if (state is CartSuccessState) {
          return _buildCart(context, state.cartItems);
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ===== Cart Content =====
  Widget _buildCart(BuildContext context, List<CartEntity> items) {
    final subtotal = items.fold<double>(0, (sum, item) {
      final discounted = item.price * (1 - item.discountPercentage / 100);
      return sum + (discounted * item.quantity);
    });
    final tax = subtotal * 0.08;
    final total = subtotal + tax;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ===== Header =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Cart',
                            style: AppTextStyles.bold(
                              size: 22,
                              color: AppColors.darkBlueIcon,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${items.length} ${items.length == 1 ? 'item' : 'items'} selected',
                            style: AppTextStyles.regular(
                              size: 13,
                              color: AppColors.textSecondary,
                              font: AppFont.inter,
                            ),
                          ),
                        ],
                      ),
                      // Clear Cart
                      GestureDetector(
                        onTap: () =>
                            context.read<CartBloc>().add(ClearCartEvent()),
                        child: Text(
                          'Clear All',
                          style: AppTextStyles.semibold(
                            size: 13,
                            color: AppColors.sale,
                            font: AppFont.inter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== Cart Items =====
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CartItemWidget(item: items[index]),
                  childCount: items.length,
                ),
              ),

              // ===== Hint =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Text(
                    'Swipe items left to remove',
                    style: AppTextStyles.regular(
                      size: 12,
                      color: AppColors.textTertiary,
                      font: AppFont.inter,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ===== Order Summary =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: AppTextStyles.bold(
                          size: 16,
                          color: AppColors.darkBlueIcon,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _summaryRow(
                        'Subtotal',
                        '\$${subtotal.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      _summaryRow(
                        'Shipping',
                        'Calculated at checkout',
                        valueColor: AppColors.gold,
                      ),
                      const SizedBox(height: 10),
                      _summaryRow(
                        'Estimated Tax',
                        '\$${tax.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 16),
                      Container(height: 1, color: AppColors.dotsColor),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: AppTextStyles.bold(
                              size: 16,
                              color: AppColors.darkBlueIcon,
                            ),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: AppTextStyles.bold(
                              size: 18,
                              color: AppColors.darkBlueIcon,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ===== Bottom Button =====
        Container(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            MediaQuery.of(context).padding.bottom + 130,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: CustomButtonWidget(
            hieght: 56,
            width: double.infinity,
            gradient: AppColors.darkBlueGradient,
            borderRadius: 16,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.checkout,
              arguments: CheckoutArgs(
                cartItems: items,
                cartBloc: context.read<CartBloc>(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Proceed to Checkout',
                  style: AppTextStyles.bold(size: 15, color: AppColors.white),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===== Summary Row Helper =====
  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.regular(
            size: 14,
            color: AppColors.textSecondary,
            font: AppFont.inter,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.semibold(
            size: 14,
            color: valueColor ?? AppColors.primary,
            font: AppFont.inter,
          ),
        ),
      ],
    );
  }

  // ===== Empty State =====
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 72,
            color: AppColors.dotsColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Your Cart is Empty',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to get started.',
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
