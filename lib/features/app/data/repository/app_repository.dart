import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_data_source.dart';

abstract class AppRepository {
  Future<Either<Failure, bool>> isSeenOnBoarding();
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, Unit>> setSeenOnBoarding(bool isSeen);
}

class AppRepositoryImpl implements AppRepository {
  final AppDataSource appLocalDataSource;
  AppRepositoryImpl({required this.appLocalDataSource});

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = await appLocalDataSource.isLoggedIn();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSeenOnBoarding() async {
    try {
      final result = await appLocalDataSource.isSeenOnBoarding();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setSeenOnBoarding(bool isSeen) async {
    try {
      await appLocalDataSource.setSeenOnBoarding(isSeen);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
