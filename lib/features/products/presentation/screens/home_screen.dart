import 'package:fluid_boutique/core/helpers/image_helper.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_event.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/all_categouries_widget.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/home_carousel_widget.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/new_arrival_widget.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/product_list_widget.dart';
import 'package:fluid_boutique/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> carouselImages = [ImageHelper.carouselImage1];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>()
        ..add(GetAllCategoriesEvent())
        ..add(
          GetSpecificProductEvent(
            productCategory: const CategoryEntity(
              slug: 'mens-shirts',
              name: 'Mens Shirts',
            ),
          ),
        )
        ..add(
          GetSpecialProductsByCategory(
            productCategory: const CategoryEntity(
              slug: 'furniture',
              name: 'Furniture',
            ),
          ),
        ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          child: Column(
            children: [
              HomeCarouselWidget(
                images: carouselImages,
                pageController: _pageController,
              ),
              SizedBox(height: 16.h),
              const AllCategouriesWidget(),
              SizedBox(height: 16.h),
              const ProductListWidget(),
              SizedBox(height: 16.h),
              const NewArrivalWidget(),
              SizedBox(height: 90.h),
            ],
          ),
        ),
      ),
    );
  }
}
