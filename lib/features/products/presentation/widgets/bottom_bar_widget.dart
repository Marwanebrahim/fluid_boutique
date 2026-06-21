import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({
    super.key,
    required this.isWishlisted,
    required this.addToWishlist,
    required this.addToCart,
  });

  final bool isWishlisted;
  final VoidCallback addToWishlist;
  final VoidCallback addToCart;
  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Wishlist Button
            GestureDetector(
              onTap: widget.addToWishlist,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.dotsColor),
                ),
                child: Icon(
                  widget.isWishlisted
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: widget.isWishlisted
                      ? AppColors.sale
                      : AppColors.darkBlueIcon,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                hieght: 52,
                width: double.infinity,
                gradient: AppColors.goldGradient,
                borderRadius: 14,
                onTap: widget.addToCart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ADD TO CART',
                      style: AppTextStyles.bold(
                        size: 14,
                        color: AppColors.white,
                        font: AppFont.inter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
