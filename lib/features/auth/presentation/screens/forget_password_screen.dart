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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
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
                    height: 52,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.darkBlueIcon,
                    ),
                    child: const Icon(
                      Icons.lock_reset_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(28),
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
                        const SizedBox(height: 16),
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

                        const SizedBox(height: 24),
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
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthForgetPasswordSuccess) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
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
                                    const Icon(
                                      Icons.info_outline,
                                      color: AppColors.goldBrown,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
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
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColors.darkBlueIcon,
                          size: 14,
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
