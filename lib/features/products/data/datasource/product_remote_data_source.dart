import 'package:dio/dio.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/products/data/model/category_model.dart';
import 'package:fluid_boutique/features/products/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<CategoryModel>> getAllCategories();
  Future<List<ProductModel>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final result = await _dio.get(AppString.productsPath);
      final List<dynamic> response = result.data['products'];
      final products = response
          .map((e) => ProductModel.fromJson(json: e as Map<String, dynamic>))
          .toList();
      return products;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final result = await _dio.get(AppString.categoriesPath);
      final List<dynamic> response = result.data;
      final categories = response
          .map((e) => CategoryModel.fromJson(json: e as Map<String, dynamic>))
          .toList();
      return categories;
    } on DioException {
      rethrow; 
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final result = await _dio.get("${AppString.categoryPath}/$category/");
      final List<dynamic> response = result.data['products'];
      final products = response
          .map((e) => ProductModel.fromJson(json: e as Map<String, dynamic>))
          .toList();
      return products;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }
}
