import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';

class RemoveFromWishlistUseCase {
  final WishlistRepository wishlistRepository;
  RemoveFromWishlistUseCase({required this.wishlistRepository});

  Future<Either<Failure, Unit>> call({required int productId}) async {
    return await wishlistRepository.removeFromWishlist(productId);
  }
}
