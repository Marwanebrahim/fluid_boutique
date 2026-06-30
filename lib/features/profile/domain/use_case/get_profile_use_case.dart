import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/profile/domain/entity/profile_entity.dart';
import 'package:fluid_boutique/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository profileRepository;
  GetProfileUseCase({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> call()async {
    return await profileRepository.getProfile();
  }
}