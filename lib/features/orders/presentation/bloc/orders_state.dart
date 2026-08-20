import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';

abstract class OrdersState extends Equatable {}

class OrdersInitialState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersLoadingState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersSuccessState extends OrdersState {
  final OrderEntity? activeOrder;
  final List<OrderEntity> recentOrders;

  OrdersSuccessState({required this.activeOrder, required this.recentOrders});

  @override
  List<Object?> get props => [activeOrder, recentOrders];
}

class OrdersEmptyState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersErrorState extends OrdersState {
  final String message;
  OrdersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class OrderPlacedLoadingState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrderPlacedSuccessState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrderPlacedErrorState extends OrdersState {
  final String message;
  OrderPlacedErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
