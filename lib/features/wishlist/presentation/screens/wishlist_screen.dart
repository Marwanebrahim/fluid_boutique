import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/core/routing/args/product_details_args.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:fluid_boutique/features/wishlist/presentation/widgets/empty_wishlist_widget.dart';
import 'package:fluid_boutique/features/wishlist/presentation/widgets/wishlist_card_widget.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listenWhen: (previous, current) => current is GetProductDataSuccessState,
      listener: (context, state) {
        if (state is GetProductDataSuccessState) {
          Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: ProductDetailsArgs(
              product: state.productData,
              wishlistBloc: context.read<WishlistBloc>(),
              cartBloc: context.read<CartBloc>(),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is WishlistLoadingState ||
          current is WishlistSuccessState ||
          current is WishlistErrorState,
      builder: (context, state) {
        if (state is WishlistLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is WishlistErrorState) {
          CustomErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<WishlistBloc>().add(GetWishlistEvent());
            },
          );
        }

        if (state is WishlistSuccessState) {
          if (state.wishlist.isEmpty) {
            return const EmptyWishlistWidget();
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saved Gems',
                            style: AppTextStyles.bold(
                              size: 22,
                              color: AppColors.darkBlueIcon,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${state.wishlist.length} ${state.wishlist.length == 1 ? 'Item' : 'Items'} in your collection',
                            style: AppTextStyles.regular(
                              size: 13,
                              color: AppColors.textSecondary,
                              font: AppFont.inter,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.dotsColor),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.tune_rounded,
                              size: 16,
                              color: AppColors.darkBlueIcon,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Filter',
                              style: AppTextStyles.semibold(
                                size: 13,
                                color: AppColors.darkBlueIcon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Grid
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => WishlistCardWidget(
                      product: state.wishlist[index],
                      onTap: () {
                        context.read<WishlistBloc>().add(
                          GetProductDataEvent(
                            productID: state.wishlist[index].id,
                          ),
                        );
                      },
                    ),
                    childCount: state.wishlist.length,
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
