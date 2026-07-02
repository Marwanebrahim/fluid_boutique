import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/dialogs/auth_dialog.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_event.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_state.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Form(
            key: _formKey,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailureState) {
                  showAuthDialog(context: context, message: state.message);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 52.h,
                    width: 64.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.darkBlueIcon,
                    ),
                    child: const Icon(
                      Icons.lock_reset_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Reset Password",
                    style: AppTextStyles.bold(
                      size: 36,
                      color: AppColors.darkBlueIcon,
                    ),
                  ),
                  Text(
                    "Enter the email associated with your account and we'll send a recovery link.",
                    style: AppTextStyles.regular(
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: AppTextStyles.semibold(
                            size: 14,
                            color: AppColors.darkBlueIcon,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          hintWidget: Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                color: AppColors.textSecondary,
                              ),
                              Text(
                                "name@example.com",
                                style: AppTextStyles.semibold(
                                  size: 16,
                                  font: AppFont.inter,
                                  color: AppColors.dotsColor.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isPassword: false,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(p0)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          controller: emailController,
                        ),

                        SizedBox(height: 24.h),
                        CustomButtonWidget(
                          hieght: 56,
                          width: 276,
                          backgroundColor: AppColors.gold,
                          borderRadius: 12,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            context.read<AuthBloc>().add(
                              ForgetPasswordEvent(email: emailController.text),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send Reset Link",
                                style: AppTextStyles.semibold(
                                  size: 16,
                                  color: AppColors.white,
                                  font: AppFont.inter,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.arrow_forward, color: AppColors.white),
                            ],
                          ),
                        ),

                        SizedBox(height: 32.h),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthForgetPasswordSuccess) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.gold.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: AppColors.goldBrown,
                                      size: 20.w,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Confirmation sent!",
                                            style: AppTextStyles.semibold(
                                              size: 14,
                                              color: AppColors.brown,
                                              font: AppFont.inter,
                                            ),
                                          ),
                                          Text(
                                            "We've sent an email to the address provided with further instructions.",
                                            style: AppTextStyles.regular(
                                              size: 12,
                                              font: AppFont.inter,
                                              color: AppColors.brown.withValues(
                                                alpha: 0.8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColors.darkBlueIcon,
                          size: 14.w,
                        ),
                        Text(
                          "Back to Login",
                          style: AppTextStyles.semibold(
                            size: 14,
                            color: AppColors.darkBlueIcon,
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
        ),
      ),
    );
  }
}
