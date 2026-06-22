import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class GetSearchHistoryUseCase {
  final ProductRepository repository;
  GetSearchHistoryUseCase({required this.repository});
  Future<Either<Failure, List<String>>> call() async {
    return await repository.getSearchHistory();
  }
}
