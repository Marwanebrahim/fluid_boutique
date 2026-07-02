import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_event.dart';
import 'package:fluid_boutique/features/cart/presentation/widgets/review_item.dart';
import 'package:fluid_boutique/features/cart/presentation/widgets/section_header.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_event.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_state.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartEntity> cartItems;
  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'label': 'Credit Card',
      'subtitle': 'Visa ending in 4242',
      'icon': Icons.credit_card_rounded,
    },
    {
      'label': 'PayPal',
      'subtitle': '',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {'label': 'Apple Pay', 'subtitle': '', 'icon': Icons.apple_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.cartItems.fold<double>(0, (sum, item) {
      final discounted = item.price * (1 - item.discountPercentage / 100);
      return sum + (discounted * item.quantity);
    });
    final tax = subtotal * 0.08;
    final total = subtotal + tax;

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Checkout',
                    style: AppTextStyles.bold(
                      size: 26,
                      color: AppColors.darkBlueIcon,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Finalize your curated selection.',
                    style: AppTextStyles.regular(
                      size: 13,
                      color: AppColors.textSecondary,
                      font: AppFont.inter,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ===== 1. Shipping Address =====
                  SectionHeader(
                    title: 'Shipping Address',
                    step: 1,
                    action: 'Edit',
                  ),
                  SizedBox(height: 12.h),
                  _addressCard(),

                  SizedBox(height: 24.h),

                  // ===== 2. Payment Method =====
                  SectionHeader(title: 'Payment Method', step: 2),
                  SizedBox(height: 12.h),
                  ..._paymentMethods.asMap().entries.map(
                    (entry) => _paymentOption(
                      index: entry.key,
                      label: entry.value['label'],
                      subtitle: entry.value['subtitle'],
                      icon: entry.value['icon'],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ===== 3. Review Items =====
                  SectionHeader(title: 'Review Items', step: 3),
                  SizedBox(height: 12.h),
                  ...widget.cartItems.map((item) => ReviewItem(item: item)),

                  SizedBox(height: 20.h),
                  Container(height: 1, color: AppColors.dotsColor),
                  SizedBox(height: 16.h),

                  // ===== Summary =====
                  _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                  SizedBox(height: 8.h),
                  _summaryRow('Shipping', 'Free', valueColor: AppColors.gold),
                  SizedBox(height: 8.h),
                  _summaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
                  SizedBox(height: 16.h),
                  Container(height: 1, color: AppColors.dotsColor),
                  SizedBox(height: 16.h),
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
                          size: 20,
                          color: AppColors.darkBlueIcon,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ===== Place Order Button =====
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 16.r,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                BlocListener<OrdersBloc, OrdersState>(
                  listener: (context, state) {
                    if (state is OrderPlacedSuccessState) {
                      context.read<CartBloc>().add(ClearCartEvent());
                      Navigator.pushReplacementNamed(context, AppRoutes.orders);
                    }
                    if (state is OrderPlacedErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  },
                  child: CustomButtonWidget(
                    hieght: 56,
                    width: double.infinity,
                    gradient: AppColors.goldGradient,
                    borderRadius: 16,
                    onTap: () {
                      context.read<OrdersBloc>().add(
                        PlaceOrderEvent(
                          cartItems: widget.cartItems,
                          total: total,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Place Order',
                          style: AppTextStyles.bold(
                            size: 15,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                          size: 18.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 12.w,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'SECURE SSL ENCRYPTED CHECKOUT',
                      style: AppTextStyles.regular(
                        size: 10,
                        color: AppColors.textTertiary,
                        font: AppFont.inter,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Address Card =====
  Widget _addressCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.gold,
              size: 18.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Rivera',
                  style: AppTextStyles.semibold(
                    size: 14,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '742 Evergreen Terrace\nSpringfield, IL 62704\nUnited States\n+1 (555) 012-3456',
                  style: AppTextStyles.regular(
                    size: 12,
                    color: AppColors.textSecondary,
                    font: AppFont.inter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Payment Option =====
  Widget _paymentOption({
    required int index,
    required String label,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedPayment == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: AppColors.primary),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.semibold(
                      size: 14,
                      color: AppColors.darkBlueIcon,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: AppTextStyles.regular(
                        size: 11,
                        color: AppColors.textTertiary,
                        font: AppFont.inter,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.dotsColor,
                  width: 2.w,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.w, color: AppColors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ===== Summary Row =====
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
            color: valueColor ?? AppColors.darkBlueIcon,
            font: AppFont.inter,
          ),
        ),
      ],
    );
  }
}
