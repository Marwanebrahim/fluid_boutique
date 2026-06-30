import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final ProfileEntity profile;
  ProfileSuccessState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogOutLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LogOutSuccessState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LogOutErrorState extends ProfileState {
  final String message;
  LogOutErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
