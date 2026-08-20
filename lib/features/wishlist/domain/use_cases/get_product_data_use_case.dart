import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';

class GetProductDataUseCase {
  final WishlistRepository wishlistRepository;
  GetProductDataUseCase({required this.wishlistRepository});

  Future<Either<Failure, ProductEntity>> call({required int productId}) async {
    return await wishlistRepository.getProductData(productId);
  }
}
