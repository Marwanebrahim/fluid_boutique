import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/features/app/presentation/widgets/custom_app_bar.dart';
import 'package:fluid_boutique/features/products/presentation/screens/home_screen.dart';
import 'package:fluid_boutique/features/products/presentation/screens/search_screen.dart';
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
    const LiquidGlassNavItem(
      icon: Icons.home_filled,
      label: 'Home',
      tooltip: 'Home Screen',
    ),
    const LiquidGlassNavItem(
      icon: Icons.search_outlined,
      label: 'Search',
      tooltip: 'Search Screen',
    ),
    const LiquidGlassNavItem(
      icon: Icons.shopping_cart_outlined,
      label: 'Cart',
      tooltip: 'Cart Screen',
    ),
    const LiquidGlassNavItem(
      icon: Icons.favorite_outline_outlined,
      label: 'Wishlist',
      tooltip: 'Wishlist Screen',
    ),

    const LiquidGlassNavItem(
      icon: Icons.person_outlined,
      label: 'Profile',
      tooltip: 'Profile Screen',
    ),
  ];
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const Center(child: Text('Cart Screen')),
    const Center(child: Text('Wishlist Screen')),
    const Center(child: Text('Profile Screen')),
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
    const CustomAppBar(title: 'Fluid Boutique'),
    const CustomAppBar(title: 'Fluid Boutique'),
    const CustomAppBar(title: 'Fluid Boutique'),
    const CustomAppBar(title: 'Fluid Boutique'),
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
            backgroundColor: AppColors.white,
            activeColor: AppColors.navSelected,
            inactiveColor: AppColors.navIcon,
            shadowColor: AppColors.primary,
            shadowOffset: const Offset(0, 12),
            shadowBlurRadius: 32,
            enableShadow: true,
            rippleColor: AppColors.primary,
            borderRadius: 24,
            borderWidth: 1.5,
          ),
        ],
      ),
    );
  }
}
