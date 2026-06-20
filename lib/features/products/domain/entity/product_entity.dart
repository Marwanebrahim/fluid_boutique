class ProductEntity {
  final int id;
  final String title;
  final String? brand;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String availabilityStatus;
  final List<String> tags;
  final List<String> images;
  final String thumbnail;
  final int reviewsNumber;

  const ProductEntity({
    required this.id,
    required this.title,
    this.brand,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.availabilityStatus,
    required this.tags,
    required this.images,
    required this.thumbnail,
    required this.reviewsNumber,
  });
}
