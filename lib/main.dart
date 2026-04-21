import 'package:fluid_boutique/core/configs/app_theme.dart';
import 'package:fluid_boutique/core/routing/app_router.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/injection_container.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: AppRoutes.splashScreen,
      theme: appTheme,
    );
  }
}
feat: Implement onboarding and splash screens with state management

- Add app failures and strings for error handling.
- Create app theme configuration.
- Implement exception classes for error handling.
- Define failure classes for different error types.
- Create Hive helper for local storage management.
- Add image helper for onboarding images.
- Set up routing with app routes and router.
- Implement local data source for onboarding and login state.
- Create repository for data access and error handling.
- Implement BLoC for managing app state and events.
- Create onboarding and splash screens with navigation logic.
- Add custom button widget for UI consistency.
- Set up dependency injection for app components.
