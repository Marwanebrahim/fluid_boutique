import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_event.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AppBloc>().add(IsSeenOnBoardingEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is IsSeenOnBoarding) {
          if (state.isSeenOnBoarding) {
            context.read<AppBloc>().add(IsLoggedInEvent());
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
          }
        } else if (state is IsLoggedIn) {
          if (state.isLoggedIn) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.darkBlueGradient),
          child: Column(
            spacing: 4,
            children: [
              const Spacer(),
              //logo
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(
                  Icons.water_drop_rounded,
                  color: AppColors.darkBlueIcon,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Fluid Boutique",
                style: AppTextStyles.bold(
                  size: 36,
                ).copyWith(color: AppColors.white),
              ),
              Text(
                "THE LIQUID CURATOR",
                style: AppTextStyles.regular(size: 14).copyWith(
                  color: AppColors.textTertiary.withValues(alpha: 0.6),
                ),
              ),
              const Spacer(),
              // progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.textTertiary.withValues(
                      alpha: 0.15,
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.goldBrown,
                    ),
                    minHeight: 2,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundColor: AppColors.goldBrown, radius: 4),
                  Text(
                    "INITIALISING EXPERIENCE",
                    style: AppTextStyles.regular(size: 10).copyWith(
                      color: AppColors.textTertiary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),

              Text(
                "Version 1.0.0",
                style: AppTextStyles.regular(size: 10).copyWith(
                  color: AppColors.textTertiary.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
