import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.imageController,
    required this.product,
  });
  final PageController imageController;
  final ProductEntity product;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return SliverAppBar(
      expandedHeight: 480,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.darkBlueIcon,
              size: 18,
            ),
          ),
        ),
      ),
      title: Text(
        'Fluid Boutique',
        style: AppTextStyles.bold(size: 16, color: AppColors.darkBlueIcon),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Images PageView
            PageView.builder(
              controller: widget.imageController,
              itemCount: product.images.isNotEmpty ? product.images.length : 1,
              itemBuilder: (context, index) {
                final imageUrl = product.images.isNotEmpty
                    ? product.images[index]
                    : product.thumbnail;
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, _) => Container(
                    color: AppColors.white,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColors.textTertiary,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
            // Dots Indicator
            if (product.images.length > 1)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: widget.imageController,
                    count: product.images.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      dotWidth: 15,
                      dotHeight: 6,
                      dotColor: AppColors.dotsColor,
                      activeDotColor: AppColors.darkBlueIcon,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
