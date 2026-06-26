import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/data/mapper/cart_entity_mapper.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;

  AddToCartUseCase({required this.cartRepository});

  Future<Either<Failure, Unit>> call({required CartEntity product}) async =>
      await cartRepository.addToCart(product: product.toModel());
}
