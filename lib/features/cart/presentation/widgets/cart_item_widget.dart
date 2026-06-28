import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartEntity item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final discountedPrice = item.price * (1 - item.discountPercentage / 100);

    return Dismissible(
      key: Key(item.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          context.read<CartBloc>().add(RemoveFromCartEvent(product: item)),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.sale,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.white,
          size: 24,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.dotsColor,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Delete
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.semibold(
                            size: 13,
                            color: AppColors.darkBlueIcon,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<CartBloc>().add(
                          RemoveFromCartEvent(product: item),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Color + Size
                  Text(
                    'Size: ${item.size}  •  ${item.color}',
                    style: AppTextStyles.regular(
                      size: 11,
                      color: AppColors.textTertiary,
                      font: AppFont.inter,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Price + Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.bold(
                          size: 14,
                          color: AppColors.darkBlueIcon,
                        ),
                      ),
                      // Quantity Control
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.dotsColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            _qtyButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (item.quantity > 1) {
                                  context.read<CartBloc>().add(
                                    UpdateCartQuantityEvent(
                                      product: item,
                                      quantity: item.quantity - 1,
                                    ),
                                  );
                                } else {
                                  context.read<CartBloc>().add(
                                    RemoveFromCartEvent(product: item),
                                  );
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                '${item.quantity}',
                                style: AppTextStyles.bold(
                                  size: 13,
                                  color: AppColors.darkBlueIcon,
                                ),
                              ),
                            ),
                            _qtyButton(
                              icon: Icons.add,
                              onTap: () {
                                if (item.quantity < item.stock) {
                                  context.read<CartBloc>().add(
                                    UpdateCartQuantityEvent(
                                      product: item,
                                      quantity: item.quantity + 1,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(icon, size: 14, color: AppColors.darkBlueIcon),
      ),
    );
  }
}
