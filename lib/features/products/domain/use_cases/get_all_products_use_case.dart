import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository productRepository;
  GetAllProductsUseCase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> call() async =>
      await productRepository.getAllProducts();
}
