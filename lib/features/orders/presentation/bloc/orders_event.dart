import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';

abstract class OrdersEvent extends Equatable {}

class GetUserOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends OrdersEvent {
  final List<CartEntity> cartItems;
  final double total;

  PlaceOrderEvent({required this.cartItems, required this.total});

  @override
  List<Object?> get props => [cartItems, total];
}
