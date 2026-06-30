import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:fluid_boutique/features/profile/data/mapper/profile_model_mapper.dart';
import 'package:fluid_boutique/features/profile/domain/entity/profile_entity.dart';
import 'package:fluid_boutique/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final model = await profileRemoteDataSource.getProfile();
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await profileRemoteDataSource.logOut();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
