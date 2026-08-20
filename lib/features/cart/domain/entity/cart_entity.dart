class CartEntity {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double discountPercentage;
  final int stock;
  final String color;
  final String size;
  final int quantity;
  CartEntity({
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
}
