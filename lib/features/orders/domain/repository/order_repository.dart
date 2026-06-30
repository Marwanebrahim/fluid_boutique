import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getUserOrders();

  Future<Either<Failure, Unit>> placeOrder({required OrderEntity order});
}
