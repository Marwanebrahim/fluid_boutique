class WishlistModel {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final String availabilityStatus;
  final String thumbnail;

  WishlistModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.availabilityStatus,
    required this.thumbnail,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json['id'] as int,
    title: json['title'] as String,
    price: (json['price'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num).toDouble(),
    availabilityStatus: json['availabilityStatus'] as String,
    thumbnail: json['thumbnail'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'price': price,
    'discountPercentage': discountPercentage,
    'availabilityStatus': availabilityStatus,
    'thumbnail': thumbnail,
  };
}
