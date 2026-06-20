import 'package:fluid_boutique/features/products/data/model/dimension_model.dart';
import 'package:fluid_boutique/features/products/data/model/meta_model.dart';
import 'package:fluid_boutique/features/products/data/model/review_model.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final double weight;
  final DimensionsModel dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewModel> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaModel meta;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] as String?,
      sku: json['sku'] as String,
      weight: (json['weight'] as num).toDouble(),
      dimensions: DimensionsModel.fromJson(json: json['dimensions']),
      warrantyInformation: json['warrantyInformation'] as String,
      shippingInformation: json['shippingInformation'] as String,
      availabilityStatus: json['availabilityStatus'] as String,
      reviews: (json['reviews'] as List)
          .map((r) => ReviewModel.fromJson(json: r))
          .toList(),
      returnPolicy: json['returnPolicy'] as String,
      minimumOrderQuantity: json['minimumOrderQuantity'] as int,
      meta: MetaModel.fromJson(json: json['meta']),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] as String,
    );
  }
}
