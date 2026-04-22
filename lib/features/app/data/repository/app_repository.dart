import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';

abstract class AppRepository {
  Future<Either<Failure, bool>> isSeenOnBoarding();
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, Unit>> setSeenOnBoarding(bool isSeen);
}

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource appLocalDataSource;
  final AppRemoteDataSource appRemoteDataSource;
  AppRepositoryImpl({required this.appLocalDataSource, required this.appRemoteDataSource});

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = await appRemoteDataSource.isLoggedIn();
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
