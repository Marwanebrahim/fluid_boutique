import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/helpers/image_helper.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_event.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    super.key,
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: AppTextStyles.bold(size: 24, color: AppColors.darkBlueIcon),
            ),
            Text(
              "Please enter your credentials to continue your curation.",
              style: AppTextStyles.regular(
                size: 14,
                font: AppFont.inter,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              "EMAIL ADDRESS",
              style: AppTextStyles.semibold(
                size: 12,
                color: AppColors.textSecondary,
                font: AppFont.inter,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintWidget: Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: AppColors.dotsColor,
                  ),
                  Text(
                    "curator@fluid.com",
                    style: AppTextStyles.regular(
                      size: 16,
                      color: AppColors.dotsColor.withValues(alpha: 0.6),
                      font: AppFont.inter,
                    ),
                  ),
                ],
              ),
              isPassword: false,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
      
                return null;
              },
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PASSWORD",
                  style: AppTextStyles.semibold(
                    size: 12,
                    color: AppColors.textSecondary,
                    font: AppFont.inter,
                  ),
                ),
      
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: AppTextStyles.semibold(
                      size: 12,
                      color: AppColors.goldBrown,
                      font: AppFont.inter,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintWidget: Row(
                spacing: 4,
                children: [
                  Icon(Icons.lock_outline, size: 20, color: AppColors.dotsColor),
                  Text(
                    "••••••••",
                    style: AppTextStyles.regular(
                      size: 16,
                      color: AppColors.dotsColor.withValues(alpha: 0.6),
                      font: AppFont.inter,
                    ),
                  ),
                ],
              ),
              isPassword: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomButtonWidget(
              hieght: 56,
              width: 278,
              borderRadius: 8,
              gradient: AppColors.darkBlueGradient,
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                context.read<AuthBloc>().add(
                  LogInWithEmailEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    "Login",
                    style: AppTextStyles.bold(size: 16, color: AppColors.white),
                  ),
                  Icon(Icons.arrow_forward, size: 10, color: AppColors.white),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                "OR CONTINUE WITH",
                style: AppTextStyles.regular(
                  size: 12,
                  color: AppColors.textSecondary,
                  font: AppFont.inter,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    hieght: 56,
                    width: 278,
                    borderRadius: 8,
                    backgroundColor: AppColors.background,
                    onTap: () {
                      context.read<AuthBloc>().add(LogInWithGoogleEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        SvgPicture.asset(ImageHelper.googleIcon),
                        Text(
                          "Login with Google",
                          style: AppTextStyles.semibold(
                            size: 16,
                            color: AppColors.darkBlueIcon,
                            font: AppFont.inter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
