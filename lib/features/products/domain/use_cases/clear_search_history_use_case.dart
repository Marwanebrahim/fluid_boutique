import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class ClearSearchHistoryUseCase {
  final ProductRepository repository;

  ClearSearchHistoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return repository.clearSearchHistory();
  }
}
