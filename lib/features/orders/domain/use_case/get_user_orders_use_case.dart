import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';
import 'package:fluid_boutique/features/orders/domain/repository/order_repository.dart';

class GetUserOrdersUseCase {
  final OrdersRepository ordersRepository;
  GetUserOrdersUseCase({required this.ordersRepository});

  Future<Either<Failure, List<OrderEntity>>> call() {
    return ordersRepository.getUserOrders();
  }
}
