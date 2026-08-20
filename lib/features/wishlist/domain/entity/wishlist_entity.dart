class WishlistEntity {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final String availabilityStatus;
  final String thumbnail;

  WishlistEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.availabilityStatus,
    required this.thumbnail,
  });
}
