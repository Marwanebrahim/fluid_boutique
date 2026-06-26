import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';

sealed class WishlistState extends Equatable {}

class WishlistInitialState extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistLoadingState extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class WishlistSuccessState extends WishlistState {
  final List<WishlistEntity> wishlist;
  WishlistSuccessState({required this.wishlist});
  @override
  List<Object?> get props => [wishlist];
}

class ProductAddedSuccessState extends WishlistState {
  @override
  List<Object?> get props => [];
}

class ProductRemovedSuccessState extends WishlistState {
  @override
  List<Object?> get props => [];
}

class GetProductDataSuccessState extends WishlistState {
  final ProductEntity productData;
  GetProductDataSuccessState({required this.productData});
  @override
  List<Object?> get props => [productData];
}
