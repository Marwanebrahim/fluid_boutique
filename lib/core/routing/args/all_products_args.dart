import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';

class AllProductsArgs {
  final CategoryEntity? category;
  final ProductBloc productBloc;
  final WishlistBloc wishlistBloc;

  const AllProductsArgs({
    required this.category,
    required this.productBloc,
    required this.wishlistBloc,
  });
}
