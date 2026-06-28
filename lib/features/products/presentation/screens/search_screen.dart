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
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 1.5),
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
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textTertiary,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: _clearSearch,
                          child: Icon(
                            Icons.close,
                            color: AppColors.textTertiary,
                            size: 18,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
        const SizedBox(height: 12),

        // History List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: history.length,
          separatorBuilder: (_, _) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onHistoryItemTap(history[index]),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.history_rounded,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 12),
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

        const SizedBox(height: 24),
        _buildEmptyDiscovery(),
      ],
    );
  }

  // ===== Discovery Widget (Initial State) =====
  Widget _buildEmptyDiscovery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                ImageHelper.searchImage,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.shopping_bag_outlined,
                  size: 48,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Begin Your Discovery',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
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
          const Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          const SizedBox(height: 8),
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
