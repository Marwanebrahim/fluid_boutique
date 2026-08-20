import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';

sealed class CartState extends Equatable {}

class CartInitialState extends CartState {
  @override
  List<Object?> get props => [];
}

// class CartLoadingState extends CartState {
//   @override
//   List<Object?> get props => [];
// }

class CartErrorState extends CartState {
  final String message;
  CartErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class CartSuccessState extends CartState {
  final List<CartEntity> cartItems;
  CartSuccessState({required this.cartItems});
  @override
  List<Object?> get props => [cartItems];
}

class CartEmptyState extends CartState {
  @override
  List<Object?> get props => [];
}
