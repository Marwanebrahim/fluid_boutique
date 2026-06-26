import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';

class GetWishlistUseCase {
  final WishlistRepository repository;

  GetWishlistUseCase({required this.repository});

  Future<Either<Failure, List<WishlistEntity>>> call() async {
    return await repository.getWishlist();
  }
}
