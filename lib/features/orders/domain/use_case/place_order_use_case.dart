import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/data/mapper/cart_entity_mapper.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';
import 'package:fluid_boutique/features/orders/domain/repository/order_repository.dart';
import 'package:uuid/uuid.dart';

class PlaceOrderUseCase {
  final OrdersRepository ordersRepository;
  PlaceOrderUseCase({required this.ordersRepository});

  Future<Either<Failure, Unit>> call({
    required List<CartEntity> items,
    required double total,
  }) {
    final orderItems = items.map((e) => e.toOrderItemEntity()).toList();
    final order = OrderEntity(
      id: const Uuid().v4(),
      userId: '',
      status: 'pending',
      total: total,
      createdAt: DateTime.now(),
      items: orderItems,
    );
    return ordersRepository.placeOrder(order: order);
  }
}
