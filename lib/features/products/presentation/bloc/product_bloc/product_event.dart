import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';

sealed class ProductEvent extends Equatable {}

/// get all products
class GetAllProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

/// get all categories
class GetAllCategoriesEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

/// get products by category
class GetProductsByCategoryEvent extends ProductEvent {
  final CategoryEntity category;
  GetProductsByCategoryEvent({required this.category});
  @override
  List<Object?> get props => [category];
}

/// get special products
class GetSpecialProductsByCategory extends ProductEvent {
  final CategoryEntity productCategory;
  GetSpecialProductsByCategory({required this.productCategory});
  @override
  List<Object?> get props => [productCategory];
}

class GetSpecificProductEvent extends ProductEvent {
  final CategoryEntity productCategory;
  GetSpecificProductEvent({required this.productCategory});
  @override
  List<Object?> get props => [productCategory];
}
