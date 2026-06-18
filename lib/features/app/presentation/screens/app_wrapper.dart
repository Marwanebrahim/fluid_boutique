import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/features/app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_nav/liquid_glass_nav.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  int _currentIndex = 0;
  final _items = [
    LiquidGlassNavItem(
      icon: Icons.home_filled,
      label: 'Home',
      tooltip: 'Home Screen',
    ),
    LiquidGlassNavItem(
      icon: Icons.search_outlined,
      label: 'Search',
      tooltip: 'Search Screen',
    ),
    LiquidGlassNavItem(
      icon: Icons.shopping_cart_outlined,
      label: 'Cart',
      tooltip: 'Cart Screen',
    ),
    LiquidGlassNavItem(
      icon: Icons.favorite_outline_outlined,
      label: 'Wishlist',
      tooltip: 'Wishlist Screen',
    ),

    LiquidGlassNavItem(
      icon: Icons.person_outlined,
      label: 'Profile',
      tooltip: 'Profile Screen',
    ),
  ];
  final List<Widget> _screens = [
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Cart Screen')),
    Center(child: Text('Wishlist Screen')),
    Center(child: Text('Profile Screen')),
    Center(child: Text('Profile Screen')),
  ];
  List<CustomAppBar> get _appBarItems => [
    CustomAppBar(
      title: 'Fluid Boutique',
      actions: [
        IconButton(
          onPressed: () {
            onTap(1);
          },
          icon: const Icon(Icons.search_outlined),
          color: AppColors.navSelected,
        ),
      ],
    ),
    CustomAppBar(title: 'Fluid Boutique'),
    CustomAppBar(title: 'Fluid Boutique'),
    CustomAppBar(title: 'Fluid Boutique'),
    CustomAppBar(title: 'Fluid Boutique'),
  ];
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarItems[_currentIndex],
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            sizing: StackFit.expand,
            children: _screens,
          ),
          LiquidGlassBottomNav(
            items: _items,
            currentIndex: _currentIndex,
            onTap: onTap,
            backgroundColor: AppColors.white.withValues(alpha: 0.6),
            activeColor: AppColors.navSelected,
            inactiveColor: AppColors.navIcon,
            shadowColor: AppColors.primary.withValues(alpha: 0.1),
            shadowOffset: const Offset(0, 12),
            shadowBlurRadius: 40,
            enableShadow: true,
            rippleColor: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: 24,
            borderWidth: 1.5,
          ),
        ],
      ),
    );
  }
}
