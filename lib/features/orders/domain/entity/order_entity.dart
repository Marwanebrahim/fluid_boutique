import 'package:fluid_boutique/features/orders/domain/entity/order_item_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final String status;
  final double total;
  final DateTime createdAt;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  bool get isActive => status != 'delivered' && status != 'cancelled';
}
