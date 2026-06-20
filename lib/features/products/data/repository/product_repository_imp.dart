import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/core/network/network_info.dart';
import 'package:fluid_boutique/features/products/data/datasource/product_remote_data_source.dart';
import 'package:fluid_boutique/features/products/data/mapper/category_model_mapper.dart';
import 'package:fluid_boutique/features/products/data/mapper/produnt_model_mapper.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final NetworkInfo networkInfo;
  ProductRepositoryImp({
    required this.productRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final models = await productRemoteDataSource.getAllProducts();
        final products = models.map((e) => e.toEntity()).toList();
        return Right(products);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final categoriesModels = await productRemoteDataSource.getAllCategories();
      final categories = categoriesModels.map((e) => e.toEntity()).toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final models = await productRemoteDataSource.getProductsByCategory(
        category,
      );
      final products = models.map((e) => e.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
