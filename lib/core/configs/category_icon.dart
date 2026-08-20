import 'package:flutter/material.dart';

class CategoryIcons {
  static const Map<String, IconData> icons = {
    'beauty': Icons.face_retouching_natural,
    'fragrances': Icons.air,
    'furniture': Icons.chair,
    'groceries': Icons.local_grocery_store,
    'home-decoration': Icons.home_outlined,
    'kitchen-accessories': Icons.kitchen_outlined,
    'laptops': Icons.laptop,
    'mens-shirts': Icons.checkroom_outlined,
    'mens-shoes': Icons.snowshoeing,
    'mens-watches': Icons.watch_outlined,
    'mobile-accessories': Icons.phone_android_outlined,
    'motorcycle': Icons.two_wheeler,
    'skin-care': Icons.spa_outlined,
    'smartphones': Icons.smartphone,
    'sports-accessories': Icons.sports_basketball_outlined,
    'sunglasses': Icons.wb_sunny_outlined,
    'tablets': Icons.tablet_outlined,
    'tops': Icons.dry_cleaning_outlined,
    'vehicle': Icons.directions_car_outlined,
    'womens-bags': Icons.shopping_bag_outlined,
    'womens-dresses': Icons.woman_outlined,
    'womens-jewellery': Icons.diamond_outlined,
    'womens-shoes': Icons.roller_skating_outlined,
    'womens-watches': Icons.watch_outlined,
  };

  static IconData getIcon(String category) {
    return icons[category] ?? Icons.category_outlined;
  }
}
