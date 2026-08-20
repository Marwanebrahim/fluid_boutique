import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/data/mapper/produnt_model_mapper.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/data/datasource/wishlist_remote_data_source.dart';
import 'package:fluid_boutique/features/wishlist/data/mapper/wishlist_entity_mapper.dart';
import 'package:fluid_boutique/features/wishlist/data/mapper/wishlist_model_mapper.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';

class WishlistRepositoryImp implements WishlistRepository {
  final WishlistRemoteDataSource remoteWishlistDataSource;
  WishlistRepositoryImp({required this.remoteWishlistDataSource});

  @override
  Future<Either<Failure, Unit>> addToWishlist(WishlistEntity productId) async {
    try {
      final model = productId.toModel();
      final result = await remoteWishlistDataSource.addToWishlist(model);
      return result ? Right(unit) : Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WishlistEntity>>> getWishlist() async {
    try {
      final result = await remoteWishlistDataSource.getWishlist();
      final wishlistEntities = result.map((model) => model.toEntity()).toList();
      return Right(wishlistEntities);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromWishlist(int productId) async {
    try {
      final result = await remoteWishlistDataSource.removeFromWishlist(
        productId,
      );
      return result ? Right(unit) : Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductData(int productId) async {
    try {
      final result = await remoteWishlistDataSource.getProductData(productId);
      final productEntity = result.toEntity();
      return Right(productEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
