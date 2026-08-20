import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class GetAllCategoriesUseCase {
  final ProductRepository repository;
  GetAllCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() =>
      repository.getAllCategories();
}
