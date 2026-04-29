import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/auth/presentation/widgets/login_container.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fluid Boutique",
                    style: AppTextStyles.bold(
                      size: 30,
                      color: AppColors.darkBlueIcon,
                    ),
                  ),
                  Divider(
                    color: AppColors.goldBrown,
                    thickness: 4,
                    radius: BorderRadius.circular(20),
                    indent: 148,
                    endIndent: 146,
                  ),
                  const SizedBox(height: 14),
                  LoginContainer(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: _formKey,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.regular(
                          size: 14,
                          font: AppFont.inter,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signUpScreen,
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.semibold(
                            size: 14,
                            font: AppFont.inter,
                            color: AppColors.darkBlueIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Privacy Policy   Terms of Service   Contact Us",
                    style: AppTextStyles.regular(
                      size: 12,
                      font: AppFont.inter,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "© 2024 FLUID BOUTIQUE LUXURY E-COMMERCE",
                    style: AppTextStyles.regular(
                      size: 10,
                      font: AppFont.inter,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
