import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';

sealed class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductSuccessState extends ProductState {
  final List<ProductEntity> products;

  ProductSuccessState({required this.products});
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class SpecificProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class SpecificProductSuccessState extends ProductState {
  final List<ProductEntity> products;

  SpecificProductSuccessState({required this.products});
  @override
  List<Object?> get props => [products];
}

class SpecificProductErrorState extends ProductState {
  final String message;
  SpecificProductErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class SpecificCategoryProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class SpecificCategoryProductSuccessState extends ProductState {
  final List<ProductEntity> products;

  SpecificCategoryProductSuccessState({required this.products});
  @override
  List<Object?> get props => [products];
}

class SpecificCategoryProductErrorState extends ProductState {
  final String message;
  SpecificCategoryProductErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class CategoryLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class CategorySuccessState extends ProductState {
  final List<CategoryEntity> categories;

  CategorySuccessState({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class CategoryErrorState extends ProductState {
  final String message;
  CategoryErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
