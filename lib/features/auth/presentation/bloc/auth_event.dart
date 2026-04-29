sealed class AuthEvent {}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  SignUpWithEmailEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class LogInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  LogInWithEmailEvent({required this.email, required this.password});
}

class LogInWithGoogleEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
