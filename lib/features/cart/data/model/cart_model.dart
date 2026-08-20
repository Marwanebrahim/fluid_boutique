class CartModel {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double discountPercentage;
  final int stock;
  final String color;
  final String size;
  final int quantity;

  CartModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.discountPercentage,
    required this.stock,
    required this.color,
    required this.size,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      stock: json['stock'],
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'thumbnail': thumbnail,
    'price': price,
    'discountPercentage': discountPercentage,
    'stock': stock,
    'color': color,
    'size': size,
    'quantity': quantity,
  };
}
