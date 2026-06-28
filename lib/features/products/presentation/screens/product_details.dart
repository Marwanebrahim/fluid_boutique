import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_event.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/bottom_bar_widget.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/image_carousel.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/specs_grid.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _imageController = PageController();
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1;
  bool _isDescriptionExpanded = true;

  final List<Color> _palette = [
    const Color(0xFF1B2A4A),
    const Color(0xFF8B1A2A),
    const Color(0xFFB0AEC8),
  ];

  final List<String> _sizes = ['XS', 'S', 'M', 'L'];

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Scaffold(
      body: Stack(
        children: [
          // ===== Scrollable Content =====
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ===== Image Carousel SliverAppBar =====
              ImageCarousel(
                imageController: _imageController,
                product: product,
              ),
              // ===== Product Info =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Price Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Expanded(
                            child: Text(
                              product.title,
                              style: AppTextStyles.bold(
                                size: 22,
                                color: AppColors.darkBlueIcon,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${discountedPrice.toStringAsFixed(2)}',
                                style: AppTextStyles.bold(
                                  size: 20,
                                  color: AppColors.gold,
                                ),
                              ),
                              if (product.discountPercentage > 0)
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style:
                                      AppTextStyles.regular(
                                        size: 13,
                                        color: AppColors.textTertiary,
                                      ).copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Rating Row
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating.toStringAsFixed(1)} (${product.reviewsNumber})',
                            style: AppTextStyles.semibold(
                              size: 13,
                              color: AppColors.textSecondary,
                              font: AppFont.inter,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Brand / Subtitle
                      if (product.brand != null)
                        Text(
                          product.brand!,
                          style: AppTextStyles.regular(
                            size: 13,
                            color: AppColors.textTertiary,
                            font: AppFont.inter,
                          ),
                        ),
                      const SizedBox(height: 20),
                      _divider(),
                      const SizedBox(height: 20),
                      // ===== Description Section =====
                      GestureDetector(
                        onTap: () => setState(
                          () =>
                              _isDescriptionExpanded = !_isDescriptionExpanded,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'The Narrative',
                              style: AppTextStyles.bold(
                                size: 15,
                                color: AppColors.darkBlueIcon,
                              ),
                            ),
                            Icon(
                              _isDescriptionExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: AppColors.darkBlueIcon,
                            ),
                          ],
                        ),
                      ),

                      if (_isDescriptionExpanded) ...[
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: AppTextStyles.regular(
                            size: 13,
                            color: AppColors.textSecondary,
                            font: AppFont.inter,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Specs
                        SpecsGrid(productCategory: product.category),
                      ],
                      const SizedBox(height: 20),
                      _divider(),
                      const SizedBox(height: 20),
                      // ===== Select Palette =====
                      Text(
                        'SELECT PALETTE',
                        style: AppTextStyles.semibold(
                          size: 11,
                          color: AppColors.textTertiary,
                          font: AppFont.inter,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(
                          _palette.length,
                          (index) => GestureDetector(
                            onTap: () =>
                                setState(() => _selectedColorIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _palette[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedColorIndex == index
                                      ? AppColors.darkBlueIcon
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: _selectedColorIndex == index
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _divider(),
                      const SizedBox(height: 20),
                      // ===== Size Canvas =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SIZE CANVAS',
                            style: AppTextStyles.semibold(
                              size: 11,
                              color: AppColors.textTertiary,
                              font: AppFont.inter,
                            ),
                          ),
                          Text(
                            'Size Guide',
                            style: AppTextStyles.semibold(
                              size: 11,
                              color: AppColors.primary,
                              font: AppFont.inter,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(
                          _sizes.length,
                          (index) => GestureDetector(
                            onTap: () =>
                                setState(() => _selectedSizeIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: _selectedSizeIndex == index
                                    ? AppColors.primary
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _selectedSizeIndex == index
                                      ? AppColors.primary
                                      : AppColors.dotsColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _sizes[index],
                                  style: AppTextStyles.bold(
                                    size: 13,
                                    color: _selectedSizeIndex == index
                                        ? AppColors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _divider(),
                      const SizedBox(height: 20),
                      // ===== Availability Badge =====
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: product.availabilityStatus == 'In Stock'
                              ? AppColors.primary.withValues(alpha: 0.08)
                              : AppColors.cancelledBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              product.availabilityStatus == 'In Stock'
                                  ? Icons.check_circle_outline
                                  : Icons.cancel_outlined,
                              size: 14,
                              color: product.availabilityStatus == 'In Stock'
                                  ? AppColors.primary
                                  : AppColors.cancelled,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              product.availabilityStatus,
                              style: AppTextStyles.semibold(
                                size: 12,
                                color: product.availabilityStatus == 'In Stock'
                                    ? AppColors.primary
                                    : AppColors.cancelled,
                                font: AppFont.inter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ===== Bottom Bar (Wishlist + Add to Cart) =====
          BlocBuilder<WishlistBloc, WishlistState>(
            buildWhen: (previous, current) => current is WishlistSuccessState,
            builder: (context, state) {
              final isWishlisted = state is WishlistSuccessState
                  ? state.wishlist.any((item) => item.id == product.id)
                  : false;
              return BottomBarWidget(
                isWishlisted: isWishlisted,
                addToWishlist: () {
                  context.read<WishlistBloc>().add(
                    isWishlisted
                        ? RemoveFromWishlistEvent(productID: product.id)
                        : AddToWishlistEvent(
                            product: WishlistEntity(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              discountPercentage: product.discountPercentage,
                              availabilityStatus: product.availabilityStatus,
                              thumbnail: product.thumbnail,
                            ),
                          ),
                  );
                },
                addToCart: () {
                  final selectedColor = [
                    'Navy',
                    'Burgundy',
                    'Gray',
                  ][_selectedColorIndex];
                  final selectedSize = _sizes[_selectedSizeIndex];
                  final cartItem = CartEntity(
                    id: product.id,
                    title: product.title,
                    thumbnail: product.thumbnail,
                    price: product.price,
                    discountPercentage: product.discountPercentage,
                    stock: product.stock,
                    color: selectedColor,
                    size: selectedSize,
                    quantity: 1,
                  );
                  context.read<CartBloc>().add(
                    AddToCartEvent(product: cartItem),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to cart!'),
                      backgroundColor: AppColors.primary,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 1, color: AppColors.dotsColor.withValues(alpha: 0.5));
}
