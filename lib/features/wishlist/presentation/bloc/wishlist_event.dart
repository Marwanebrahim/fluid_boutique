import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';

sealed class WishlistEvent extends Equatable {}

class GetWishlistEvent extends WishlistEvent {
  @override
  List<Object?> get props => [];
}

class AddToWishlistEvent extends WishlistEvent {
  final WishlistEntity product;
  AddToWishlistEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final int productID;
  RemoveFromWishlistEvent({required this.productID});
  @override
  List<Object?> get props => [productID];
}

class GetProductDataEvent extends WishlistEvent {
  final int productID;
  GetProductDataEvent({required this.productID});
  @override
  List<Object?> get props => [productID];
}
