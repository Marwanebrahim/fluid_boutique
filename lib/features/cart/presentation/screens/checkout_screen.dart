import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/widgets/review_item.dart';
import 'package:fluid_boutique/features/cart/presentation/widgets/section_header.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                  const SizedBox(height: 4),
                  Text(
                    'Finalize your curated selection.',
                    style: AppTextStyles.regular(
                      size: 13,
                      color: AppColors.textSecondary,
                      font: AppFont.inter,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ===== 1. Shipping Address =====
                  SectionHeader(
                    title: 'Shipping Address',
                    step: 1,
                    action: 'Edit',
                  ),
                  const SizedBox(height: 12),
                  _addressCard(),

                  const SizedBox(height: 24),

                  // ===== 2. Payment Method =====
                  SectionHeader(title: 'Payment Method', step: 2),
                  const SizedBox(height: 12),
                  ..._paymentMethods.asMap().entries.map(
                    (entry) => _paymentOption(
                      index: entry.key,
                      label: entry.value['label'],
                      subtitle: entry.value['subtitle'],
                      icon: entry.value['icon'],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== 3. Review Items =====
                  SectionHeader(title: 'Review Items', step: 3),
                  const SizedBox(height: 12),
                  ...widget.cartItems.map((item) => ReviewItem(item: item)),

                  const SizedBox(height: 20),
                  Container(height: 1, color: AppColors.dotsColor),
                  const SizedBox(height: 16),

                  // ===== Summary =====
                  _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _summaryRow('Shipping', 'Free', valueColor: AppColors.gold),
                  const SizedBox(height: 8),
                  _summaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
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
                          size: 20,
                          color: AppColors.darkBlueIcon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // ===== Place Order Button =====
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
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
            child: Column(
              children: [
                CustomButtonWidget(
                  hieght: 56,
                  width: double.infinity,
                  gradient: AppColors.goldGradient,
                  borderRadius: 16,
                  onTap: () {
                    // TODO: Place Order → Orders feature
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
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppColors.gold,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
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
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 12),
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
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.dotsColor,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: AppColors.white)
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
