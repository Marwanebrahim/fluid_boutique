import 'package:fluid_boutique/features/cart/data/model/cart_model.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_item_entity.dart';

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
    quantity: quantity,
  );
}

extension CartEntityMapper on CartEntity {
  OrderItemEntity toOrderItemEntity() => OrderItemEntity(
    title: title,
    thumbnail: thumbnail,
    price: price,
    quantity: quantity,
    color: color,
    size: size,
  );
}
