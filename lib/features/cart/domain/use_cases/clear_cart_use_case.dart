import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository cartRepository;

  ClearCartUseCase({required this.cartRepository});
  Future<Either<Failure, Unit>> call() async =>
      await cartRepository.clearCart();
}
