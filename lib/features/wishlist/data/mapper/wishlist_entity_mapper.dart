import 'package:fluid_boutique/features/wishlist/data/model/wishlist_model.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';

extension WishlistEntityMapper on WishlistEntity {
  WishlistModel toModel() {
    return WishlistModel(
      id: id,
      title: title,
      price: price,
      discountPercentage: discountPercentage,
      availabilityStatus: availabilityStatus,
      thumbnail: thumbnail,
    );
  }
}
