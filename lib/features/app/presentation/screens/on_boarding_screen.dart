import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_event.dart';
import 'package:fluid_boutique/features/app/presentation/helper/onboarding_helper.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool get _isLastPage => _currentPage == onboardingImages.length - 1;

  void _onNext() {
    if (_isLastPage) {
      context.read<AppBloc>().add(SetSeenOnBoardingEvent(isSeen: true));
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkip() {
    context.read<AppBloc>().add(SetSeenOnBoardingEvent(isSeen: true));
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // ── PageView ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingImages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 390,
                        child: Image.asset(onboardingImages[index]),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        onboardingTitles[index],
                        style: AppTextStyles.bold(
                          size: 30,
                        ).copyWith(color: AppColors.darkBlueIcon),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        onboardingBody[index],
                        style: AppTextStyles.regular(
                          size: 16,
                          font: AppFont.inter,
                        ).copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),

            // ── Dots ──
            SmoothPageIndicator(
              controller: _pageController,
              count: onboardingImages.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotColor: AppColors.dotsColor,
                activeDotColor: AppColors.darkBlueIcon,
              ),
            ),

            const SizedBox(height: 24),

            // ── Button ──
            CustomButtonWidget(
              hieght: 56,
              width: double.infinity,
              gradient: AppColors.darkBlueGradient,
              borderRadius: 12,
              onTap: _onNext,
              child: Center(
                child: Text(
                  _isLastPage ? "Get Started" : "Next",
                  style: AppTextStyles.bold(
                    size: 16,
                  ).copyWith(color: AppColors.white),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Fluid Boutique",
        style: AppTextStyles.bold(size: 20).copyWith(color: AppColors.primary),
      ),
      actions: [
        if (!_isLastPage)
          TextButton(
            onPressed: _onSkip,
            child: Text(
              "Skip",
              style: AppTextStyles.semibold(
                size: 14,
              ).copyWith(color: AppColors.textSecondary),
            ),
          ),
      ],
    );
  }
}
