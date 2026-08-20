import 'package:fluid_boutique/features/orders/data/mapper/order_item_model_mapper.dart';
import 'package:fluid_boutique/features/orders/data/model/order_model.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';

extension OrderItemModelMapper on OrderModel {
  OrderEntity toEntity() => OrderEntity(
    id: id,
    userId: userId,
    status: status,
    total: total,
    createdAt: createdAt,
    items: items.map((e) => e.toEntity()).toList(),
  );
}
