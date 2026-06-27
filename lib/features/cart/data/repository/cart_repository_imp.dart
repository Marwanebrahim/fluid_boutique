import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/cart/data/datasource/cart_remote_data_source.dart';
import 'package:fluid_boutique/features/cart/data/mapper/cart_entity_mapper.dart';
import 'package:fluid_boutique/features/cart/data/mapper/cart_model_mapper.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImp implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImp({required this.cartRemoteDataSource});
  @override
  Future<Either<Failure, Unit>> addToCart({required CartEntity product}) async {
    try {
      await cartRemoteDataSource.addToCart(product: product.toModel());
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    try {
      await cartRemoteDataSource.clearCart();
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try {
      final cartModel = await cartRemoteDataSource.getCart();
      final cartEntities = cartModel.map((model) => model.toEntity()).toList();
      return Right(cartEntities);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart({required int productId}) async {
    try {
      await cartRemoteDataSource.removeFromCart(productId: productId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
