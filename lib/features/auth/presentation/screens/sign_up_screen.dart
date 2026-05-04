import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/dialogs/auth_dialog.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_state.dart';
import 'package:fluid_boutique/features/auth/presentation/widgets/sign_up_container.dart';
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
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                }
                if (state is AuthFailureState) {
                  showAuthDialog(context: context, message: state.message);
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SignUpContainer(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      formKey: _formKey,
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
