import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );
}
