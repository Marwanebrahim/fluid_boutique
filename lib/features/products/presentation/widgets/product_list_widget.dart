import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/features/products/domain/entity/all_products_args.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_state.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Selection",
          style: AppTextStyles.bold(size: 24, color: AppColors.darkBlueIcon),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hand-picked styles for your wardrobe.",
              style: AppTextStyles.regular(
                size: 14,
                color: AppColors.textSecondary,
                font: AppFont.inter,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<ProductBloc>().add(GetAllProductsEvent());
                Navigator.pushNamed(
                  context,
                  AppRoutes.allProducts,
                  arguments: AllProductsArgs(
                    category: null,
                    productBloc: context.read<ProductBloc>(),
                  ),
                );
              },
              child: Text(
                "View All",
                style: AppTextStyles.bold(
                  size: 14,
                  color: AppColors.darkBlueIcon,
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) =>
              current is SpecificProductSuccessState ||
              current is SpecificProductErrorState ||
              current is SpecificProductLoadingState,
          builder: (BuildContext context, ProductState state) {
            if (state is SpecificProductSuccessState) {
              return SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: state.products.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return ProductCardWidget(
                      product: state.products[index],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productDetails,
                        arguments: state.products[index],
                      ),
                    );
                  },
                ),
              );
            } else if (state is SpecificProductErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.semibold(
                    size: 20,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
              );
            } else if (state is SpecificProductLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
