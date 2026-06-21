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

class NewArrivalWidget extends StatelessWidget {
  const NewArrivalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Arrivals',
              style: AppTextStyles.bold(
                size: 24,
                color: AppColors.darkBlueIcon,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<ProductBloc>().add(GetAllProductsEvent());
                Navigator.pushNamed(
                  context,
                  AppRoutes.allProducts,
                  arguments: AllProductsArgs(category: null, productBloc: context.read<ProductBloc>()),
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
        // Grid
        BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) =>
              current is SpecificCategoryProductSuccessState ||
              current is SpecificCategoryProductErrorState ||
              current is SpecificCategoryProductLoadingState,
          builder: (context, state) {
            if (state is SpecificCategoryProductLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SpecificCategoryProductErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.semibold(
                    size: 16,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
              );
            }
            if (state is SpecificCategoryProductSuccessState) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                itemCount: state.products.length > 6
                    ? 6
                    : state.products.length,
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
