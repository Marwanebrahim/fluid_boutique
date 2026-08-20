import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/core/helpers/image_helper.dart';
import 'package:fluid_boutique/core/routing/app_routes.dart';
import 'package:fluid_boutique/core/routing/args/product_details_args.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_state.dart';
import 'package:fluid_boutique/features/products/presentation/widgets/product_card_widget.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/shared/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<SearchBloc>().add(GetSearchHistoryEvent());
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      context.read<SearchBloc>().add(GetSearchHistoryEvent());
    } else {
      context.read<SearchBloc>().add(SearchProductsEvent(query: query.trim()));
    }
  }

  void _onHistoryItemTap(String query) {
    _controller.text = query;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    context.read<SearchBloc>().add(SearchProductsEvent(query: query));
  }

  void _clearSearch() {
    _controller.clear();
    context.read<SearchBloc>().add(GetSearchHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // ===== Search Bar =====
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.primary, width: 1.5.w),
              ),
              child: TextField(
                controller: _controller,
                onChanged: _onSearchChanged,
                style: AppTextStyles.regular(
                  size: 14,
                  color: AppColors.darkBlueIcon,
                  font: AppFont.inter,
                ),
                decoration: InputDecoration(
                  hintText: 'Search for luxury essentials...',
                  hintStyle: AppTextStyles.regular(
                    size: 14,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textTertiary,
                    size: 18.w,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: _clearSearch,
                          child: Icon(
                            Icons.close,
                            color: AppColors.textTertiary,
                            size: 18.w,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
            ),
          ),

          // ===== Content =====
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                // ===== History States =====
                if (state is SearchHistoryLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is SearchHistorySuccessState) {
                  return _buildHistoryContent(state.searchHistory);
                }
                // ===== Search States =====
                if (state is SearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is SearchEmptyState) {
                  return _buildNoResults();
                }

                if (state is SearchSuccessState) {
                  return _buildResults(state.products);
                }

                if (state is SearchErrorState) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<SearchBloc>().add(
                          SearchProductsEvent(query: _controller.text),
                        );
                      }
                    },
                  );
                }

                return _buildEmptyDiscovery();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===== History Widget =====
  Widget _buildHistoryContent(List<String> history) {
    if (history.isEmpty) return _buildEmptyDiscovery();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: AppTextStyles.bold(
                  size: 16,
                  color: AppColors.darkBlueIcon,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<SearchBloc>().add(ClearSearchHistoryEvent());
                  context.read<SearchBloc>().add(GetSearchHistoryEvent());
                },
                child: Text(
                  'CLEAR ALL',
                  style: AppTextStyles.bold(
                    size: 12,
                    color: AppColors.primary,
                    font: AppFont.inter,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // History List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: history.length,
          separatorBuilder: (_, _) => SizedBox(height: 4.h),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onHistoryItemTap(history[index]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 18.w,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        history[index],
                        style: AppTextStyles.regular(
                          size: 14,
                          color: AppColors.darkBlueIcon,
                          font: AppFont.inter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SizedBox(height: 24.h),
        _buildEmptyDiscovery(),
      ],
    );
  }

  // ===== Discovery Widget (Initial State) =====
  Widget _buildEmptyDiscovery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 20.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.asset(
                ImageHelper.searchImage,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.shopping_bag_outlined,
                  size: 48.w,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Begin Your Discovery',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Explore our curated collection of artisanal goods and luxury essentials designed for the modern home.',
            style: AppTextStyles.regular(
              size: 13,
              color: AppColors.textSecondary,
              font: AppFont.inter,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ===== Results Grid =====
  Widget _buildResults(List<ProductEntity> products) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.62,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(
          product: products[index],
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: ProductDetailsArgs(
              product: products[index],
              wishlistBloc: context.read<WishlistBloc>(),
              cartBloc: context.read<CartBloc>(),
            ),
          ),
        );
      },
    );
  }

  // ===== No Results =====
  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.w,
            color: AppColors.textTertiary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No results found',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try a different keyword',
            style: AppTextStyles.regular(
              size: 14,
              color: AppColors.textSecondary,
              font: AppFont.inter,
            ),
          ),
        ],
      ),
    );
  }
}
