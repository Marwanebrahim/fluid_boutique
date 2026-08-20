import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository cartRepository;
  RemoveFromCartUseCase({required this.cartRepository});
  Future<Either<Failure, Unit>> call({required CartEntity product}) async =>
      await cartRepository.removeFromCart(productId: product.id);
}
