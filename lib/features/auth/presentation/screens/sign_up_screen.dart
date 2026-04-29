import 'dart:developer';

import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_event.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_state.dart';
import 'package:fluid_boutique/shared/widgets/custom_button_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: SingleChildScrollView(
              child: BlocListener<AuthBloc, AuthState>(
                listener: (BuildContext context, AuthState state) {
                  if (state is AuthFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: AppTextStyles.bold(
                              size: 26,
                              color: AppColors.darkBlueIcon,
                            ),
                          ),
                          Text(
                            "Start your journey into high-end curation",
                            style: AppTextStyles.semibold(
                              size: 16,
                              font: AppFont.inter,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            "Full Name",
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
                                  Icons.person_outline_rounded,
                                  size: 20,
                                  color: AppColors.dotsColor,
                                ),
                                Text(
                                  "Enter your full name",
                                  style: AppTextStyles.regular(
                                    size: 16,
                                    color: AppColors.dotsColor.withValues(
                                      alpha: 0.6,
                                    ),
                                    font: AppFont.inter,
                                  ),
                                ),
                              ],
                            ),
                            isPassword: false,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              if (value.length < 3) {
                                return 'Full name must be at least 3 characters';
                              }
                              if (value.length > 50) {
                                return 'Full name must be less than 50 characters';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
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
                                  "name@example.com",
                                  style: AppTextStyles.regular(
                                    size: 16,
                                    color: AppColors.dotsColor.withValues(
                                      alpha: 0.6,
                                    ),
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
                          Text(
                            "PASSWORD",
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
                                  Icons.lock_outline_rounded,
                                  size: 20,
                                  color: AppColors.dotsColor,
                                ),
                                Text(
                                  "••••••••",
                                  style: AppTextStyles.regular(
                                    size: 16,
                                    color: AppColors.dotsColor.withValues(
                                      alpha: 0.6,
                                    ),
                                    font: AppFont.inter,
                                  ),
                                ),
                              ],
                            ),
                            isPassword: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                          Text(
                            "CONFIRM PASSWORD",
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
                                  Icons.lock_reset_outlined,
                                  size: 20,
                                  color: AppColors.dotsColor,
                                ),
                                Text(
                                  "••••••••",
                                  style: AppTextStyles.regular(
                                    size: 16,
                                    color: AppColors.dotsColor.withValues(
                                      alpha: 0.6,
                                    ),
                                    font: AppFont.inter,
                                  ),
                                ),
                              ],
                            ),
                            isPassword: true,
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your password confirmation';
                              }
                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return 'Passwords do not match';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.dotsColor.withValues(
                                      alpha: 0.5,
                                    ),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                value: _termsAccepted,
                                onChanged: (value) {
                                  setState(() {
                                    _termsAccepted = value ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  "I agree to the Terms of Service and Privacy Policy",
                                  maxLines: 2,
                                  style: AppTextStyles.semibold(
                                    size: 16,
                                    color: AppColors.textSecondary,
                                    font: AppFont.inter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          CustomButtonWidget(
                            gradient: AppColors.darkBlueGradient,
                            hieght: 64,
                            width: 278,
                            borderRadius: 12,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              if (_termsAccepted == false) return;
                              context.read<AuthBloc>().add(
                                SignUpWithEmailEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                ),
                              );
                              log("5");
                              log(
                                "email: ${emailController.value.text}, password: ${passwordController.text}, name: ${nameController.text}",
                              );
                            },
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: AppTextStyles.bold(
                                  size: 16,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Already have an account?",
                                style: AppTextStyles.regular(
                                  size: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.login,
                                  );
                                },
                                child: Text(
                                  "Log In",
                                  style: AppTextStyles.semibold(
                                    size: 14,
                                    color: AppColors.darkBlueIcon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "FLUID  BOUTIQUE   EST. 2026",
                      style: AppTextStyles.bold(
                        size: 12,
                        color: AppColors.darkBlueIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
