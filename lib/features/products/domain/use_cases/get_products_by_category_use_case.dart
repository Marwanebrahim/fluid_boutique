import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository productRepository;

  GetProductsByCategoryUseCase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> call(CategoryEntity category) {
    final categoryName = category.slug;
    return productRepository.getProductsByCategory(categoryName);
  }
}
