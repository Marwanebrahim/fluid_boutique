import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/configs/category_icon.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/core/routing/args/all_products_args.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_state.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategouriesWidget extends StatelessWidget {
  const AllCategouriesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is CategoryLoadingState ||
          current is CategorySuccessState ||
          current is CategoryErrorState,
      builder: (context, state) {
        if (state is CategorySuccessState) {
          return SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (_, _) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(
                          GetProductsByCategoryEvent(category: category),
                        );
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allProducts,
                          arguments: AllProductsArgs(
                            category: category,
                            productBloc: context.read<ProductBloc>(),
                            wishlistBloc: context.read<WishlistBloc>(),
                            cartBloc: context.read<CartBloc>(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.white.withValues(alpha: 0.7),
                        foregroundColor: AppColors.primary,
                        child: Icon(
                          CategoryIcons.getIcon(category.slug),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      category.name,
                      style: AppTextStyles.semibold(
                        size: 12,
                        color: AppColors.darkBlueIcon,
                        font: AppFont.inter,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else if (state is CategoryErrorState) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.semibold(
                size: 20,
                color: AppColors.darkBlueIcon,
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
