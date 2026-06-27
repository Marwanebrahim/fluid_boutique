import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, Unit>> addToCart({required CartEntity  product});
  Future<Either<Failure, Unit>> removeFromCart({required int productId});
  Future<Either<Failure, Unit>> clearCart();
  Future<Either<Failure, List<CartEntity>>> getCart();
}
