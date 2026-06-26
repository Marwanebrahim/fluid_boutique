import 'package:fluid_boutique/features/cart/data/model/cart_model.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';

extension CartModelMapper on CartEntity {
  CartModel toModel() => CartModel(
    id: id,
    title: title,
    thumbnail: thumbnail,
    price: price,
    discountPercentage: discountPercentage,
    stock: stock,
    color: color,
    size: size,
  );
}
