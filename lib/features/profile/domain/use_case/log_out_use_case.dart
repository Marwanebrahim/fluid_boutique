import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/profile/domain/repository/profile_repository.dart';

class LogOutUseCase {
  final ProfileRepository profileRepository;
  LogOutUseCase({required this.profileRepository});

  Future<Either<Failure, Unit>> call() async {
    return await profileRepository.logOut();
  }
}
