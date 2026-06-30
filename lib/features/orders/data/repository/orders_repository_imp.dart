import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/orders/data/datasource/orders_remote_data_source.dart';
import 'package:fluid_boutique/features/orders/data/mapper/order_entity_mapper.dart';
import 'package:fluid_boutique/features/orders/data/mapper/order_model_mapper.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';
import 'package:fluid_boutique/features/orders/domain/repository/order_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource ordersRemoteDataSource;

  OrdersRepositoryImpl({required this.ordersRemoteDataSource});

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    try {
      final models = await ordersRemoteDataSource.getUserOrders();
      final orders = models.map((e) => e.toEntity()).toList();
      return Right(orders);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> placeOrder({
    required OrderEntity order,
  }) async {
    try {
      await ordersRemoteDataSource.placeOrder(order: order.toModel());
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
