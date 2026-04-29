import 'package:fluid_boutique/features/auth/data/models/user_model.dart';

sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel user;

  AuthSuccessState({required this.user});
}

class AuthLoggedOutState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}
