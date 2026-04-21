import 'package:flutter/material.dart';

class AppColors {
  // ===== Base Colors =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF9F9FA);

  // ===== Primary =====
  static const Color primary = Color(0xFF1E1B4B);
  static const Color darkBlueIcon = Color(0xFF070235);

  // ===== Accent / Gold =====
  static const Color gold = Color(0xFFFEA619);
  static const Color goldBrown = Color(0xFF855300);
  static const Color darkGold = Color(0xFFD97706);
  static const Color lightGold = Color(0xFFFFDDB8);
  static const Color brown = Color(0xFF684000);

  // ===== Text =====
  static const Color textPrimary = Color(0xFF191C1D);
  static const Color textSecondary = Color(0xFF47464F);
  static const Color textTertiary = Color(0xFF8683BA);

  // ===== UI Elements =====
  static const Color dotsColor = Color(0xFFC8C5D0);
  static const Color registerIcon = Color(0xFF787680);

  // ===== Navigation =====
  static const Color navIcon = Color(0xFF818CF8);
  static const Color navSelected = Color(0xFF312E81);

  // ===== Status =====
  static const Color red = Color(0xFFBA1A1A);
  static const Color cancelled = Color(0xFF93000A);
  static const Color cancelledBackground = Color(0xFFFFDAD6);
  static const Color sale = Color(0xFFE15D71);

  // ===== gradient =====
  static const Gradient goldGradient = LinearGradient(
    colors: [gold, goldBrown],
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkBlueGradient = LinearGradient(
    colors: [primary, darkBlueIcon],
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient lightGoldGradient = LinearGradient(
    colors: [goldBrown.withAlpha(0), goldBrown, goldBrown.withAlpha(0)],
    stops: [0, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
