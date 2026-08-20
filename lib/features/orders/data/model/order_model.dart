import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluid_boutique/features/orders/data/model/order_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String status;
  final double total;
  final DateTime createdAt;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String docId) {
    return OrderModel(
      id: docId,
      userId: map['userId'] as String,
      status: map['status'] as String,
      total: (map['total'] as num).toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      items: (map['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'status': status,
    'total': total,
    'createdAt': Timestamp.fromDate(createdAt),
    'items': items.map((e) => e.toMap()).toList(),
  };

  OrderModel copyWith({
    String? id,
    String? userId,
    String? status,
    double? total,
    DateTime? createdAt,
    List<OrderItemModel>? items,
  }) => OrderModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
    items: items ?? this.items,
  );
}
