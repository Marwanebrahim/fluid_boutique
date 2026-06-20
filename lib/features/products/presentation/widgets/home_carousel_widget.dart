import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselWidget extends StatelessWidget {
  const HomeCarouselWidget({
    super.key,
    required this.images,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 192,
                width: 342,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: images.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotColor: AppColors.dotsColor,
            activeDotColor: AppColors.darkBlueIcon,
          ),
        ),
      ],
    );
  }
}
