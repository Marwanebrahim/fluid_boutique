class OrderItemModel {
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;
  final String color;
  final String size;

  const OrderItemModel({
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      title: map['title'] as String,
      thumbnail: map['thumbnail'] as String,
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] as int,
      color: map['color'] as String,
      size: map['size'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'thumbnail': thumbnail,
    'price': price,
    'quantity': quantity,
    'color': color,
    'size': size,
  };
}
