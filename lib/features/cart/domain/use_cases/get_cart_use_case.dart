import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository cartRepository;
  GetCartUseCase({required this.cartRepository});

  Future<Either<Failure, List<CartEntity>>> call() async =>
      await cartRepository.getCart();
}
