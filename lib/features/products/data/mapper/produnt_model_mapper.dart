import 'package:fluid_boutique/features/products/data/model/product_model.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';

extension ProduntModelMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      availabilityStatus: availabilityStatus,
      tags: tags,
      images: images,
      thumbnail: thumbnail,
      reviewsNumber: reviews.length,
    );
  }
}
