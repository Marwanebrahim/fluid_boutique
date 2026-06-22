import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';

class AddSearchHistoryUseCase {
  final ProductRepository repository;

  AddSearchHistoryUseCase({required this.repository});
  Future<Either<Failure, List<String>>> call(String query) async {
    return await repository.addSearchHistory(query);
  }
}
