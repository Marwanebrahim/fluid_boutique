import 'package:fluid_boutique/features/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:fluid_boutique/features/orders/domain/use_case/place_order_use_case.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_event.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetUserOrdersUseCase getUserOrdersUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  OrdersBloc({
    required this.getUserOrdersUseCase,
    required this.placeOrderUseCase,
  }) : super(OrdersInitialState()) {
    on<GetUserOrdersEvent>(_onGetUserOrders);
    on<PlaceOrderEvent>(_onPlaceOrder);
  }

  Future<void> _onGetUserOrders(
    GetUserOrdersEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoadingState());
    final result = await getUserOrdersUseCase();
    result.fold((failure) => emit(OrdersErrorState(message: failure.message)), (
      orders,
    ) {
      if (orders.isEmpty) {
        emit(OrdersEmptyState());
        return;
      }
      final activeOrder = orders.firstWhere(
        (o) => o.isActive,
        orElse: () => orders.first,
      );
      final recentOrders = orders
          .where((o) => o.id != activeOrder.id || !activeOrder.isActive)
          .toList();
      emit(
        OrdersSuccessState(
          activeOrder: activeOrder.isActive ? activeOrder : null,
          recentOrders: recentOrders,
        ),
      );
    });
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrderPlacedLoadingState());

    final result = await placeOrderUseCase(
      items: event.cartItems,
      total: event.total,
    );

    result.fold(
      (failure) => emit(OrderPlacedErrorState(message: failure.message)),
      (_) => emit(OrderPlacedSuccessState()),
    );
  }
}
