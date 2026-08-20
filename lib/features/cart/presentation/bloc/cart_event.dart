import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';

sealed class CartEvent extends Equatable {}

class GetCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class RemoveFromCartEvent extends CartEvent {
  final CartEntity product;
  RemoveFromCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class AddToCartEvent extends CartEvent {
  final CartEntity product;
  AddToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class ClearCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCartQuantityEvent extends CartEvent {
  final CartEntity product;
  final int quantity;
  UpdateCartQuantityEvent({required this.product, required this.quantity});
  @override
  List<Object?> get props => [product, quantity];
}
