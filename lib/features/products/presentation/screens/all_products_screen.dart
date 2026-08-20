import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/core/routing/args/product_details_args.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_state.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/product_card_widget.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.category});
  final CategoryEntity? category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          category?.name ?? 'All Products',
          style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
        ),
        centerTitle: true,
        // TODO: Filter
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.filter_list,
              color: AppColors.darkBlueIcon,
              size: 24.w,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            current is ProductLoadingState ||
            current is ProductSuccessState ||
            current is ProductErrorState,
        builder: (context, state) {
          // Success
          if (state is ProductSuccessState) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.62,
              ),
              itemCount: state.products.length,
              itemBuilder: (_, index) {
                return ProductCardWidget(
                  product: state.products[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetails,
                    arguments: ProductDetailsArgs(
                      product: state.products[index],
                      wishlistBloc: context.read<WishlistBloc>(),
                      cartBloc: context.read<CartBloc>(),
                    ),
                  ),
                );
              },
            );
          }
          // Loading
          else if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          // Error
          else if (state is ProductErrorState) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<ProductBloc>().add(GetAllProductsEvent()),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
