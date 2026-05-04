import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:fluid_boutique/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, UserModel>> logInWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> logInWithGoogle();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.logInWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } on InvalidCredentialsException {
      return Left(InvalidCredentialsFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> logInWithGoogle() async {
    try {
      final user = await remoteDataSource.logInWithGoogle();
      return Right(user);
    } on AccountExistsWithDifferentCredentialException {
      return Left(AccountExistsWithDifferentCredentialFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
      return Right(user);
    } on EmailAlreadyInUseException {
      return Left(EmailAlreadyInUseFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
