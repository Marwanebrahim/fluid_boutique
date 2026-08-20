class OrderItemEntity {
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;
  final String color;
  final String size;

  const OrderItemEntity({
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
  });
}
