import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
}

class GetProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class LogOutEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}