import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseCase {
  final WishlistRepository wishlistRepository;
  AddToWishlistUseCase({required this.wishlistRepository});

  Future<Either<Failure, Unit>> call({required WishlistEntity product}) async {
    return await wishlistRepository.addToWishlist(product);
  }
}
