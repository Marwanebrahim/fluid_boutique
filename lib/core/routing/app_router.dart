import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/app/presentation/screens/on_boarding_screen.dart';
import 'package:fluid_boutique/features/app/presentation/screens/splash_screen.dart';
import 'package:fluid_boutique/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<AppBloc>(),
          child: SplashScreen(),
        ),
      );
    case AppRoutes.onBoarding:
      return MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: sl<AppBloc>(), child: OnBoardingScreen()),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text("No Route Found"))),
      );
  }
}
