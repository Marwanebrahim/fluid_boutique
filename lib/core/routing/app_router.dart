import 'dart:developer';

import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/app/presentation/screens/app_wrapper.dart';
import 'package:fluid_boutique/features/app/presentation/screens/on_boarding_screen.dart';
import 'package:fluid_boutique/features/app/presentation/screens/splash_screen.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:fluid_boutique/features/auth/presentation/screens/log_in_screen.dart';
import 'package:fluid_boutique/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:fluid_boutique/features/products/domain/entity/all_products_args.dart';
import 'package:fluid_boutique/features/products/presentation/screens/all_products_screen.dart';
import 'package:fluid_boutique/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => sl<AppBloc>(), child: SplashScreen()),
      );
    case AppRoutes.onBoarding:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<AppBloc>(),
          child: OnBoardingScreen(),
        ),
      );
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => sl<AuthBloc>(), child: LogInScreen()),
      );
    case AppRoutes.signUpScreen:
      return MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => sl<AuthBloc>(), child: SignUpScreen()),
      );
    case AppRoutes.forgetPasswordScreen:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: ForgetPasswordScreen(),
        ),
      );
    case AppRoutes.appWrapper:
      return MaterialPageRoute(builder: (_) => const AppWrapper());
    case AppRoutes.allProducts:
      final args = setting.arguments as AllProductsArgs;
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: args.productBloc,
          child: AllProductsScreen(category: args.category),
        ),
      );
    default:
      log(setting.name.toString());
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text("No Route Found"))),
      );
  }
}
