import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';

class ProductDetailsArgs {
  final ProductEntity product;
  final WishlistBloc wishlistBloc;
  const ProductDetailsArgs({required this.product, required this.wishlistBloc});
}
