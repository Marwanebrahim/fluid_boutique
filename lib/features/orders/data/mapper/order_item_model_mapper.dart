import 'package:fluid_boutique/features/orders/data/model/order_item_model.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_item_entity.dart';

extension OrderItemModelMapper on OrderItemModel{
  OrderItemEntity toEntity() => OrderItemEntity(
        title: title,
        thumbnail: thumbnail,
        price: price,
        quantity: quantity,
        color: color,
        size: size,
      );
}