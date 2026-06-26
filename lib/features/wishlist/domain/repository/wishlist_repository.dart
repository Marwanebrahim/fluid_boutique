import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure, Unit>> addToWishlist(WishlistEntity productId);
  Future<Either<Failure, Unit>> removeFromWishlist(int productId);
  Future<Either<Failure, List<WishlistEntity>>> getWishlist();
  Future<Either<Failure, ProductEntity>> getProductData(int productId);
}
