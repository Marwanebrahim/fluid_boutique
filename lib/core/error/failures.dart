import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

// ── App ─────────────────────────────────────────
class ServerFailure extends Failure {
  const ServerFailure() : super(message: 'Something went wrong, try again');
}

class OfflineFailure extends Failure {
  const OfflineFailure() : super(message: 'No internet connection');
}

class CacheFailure extends Failure {
  const CacheFailure() : super(message: 'Local storage error');
}

// ── Auth ─────────────────────────────────────────
class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure()
    : super(message: 'This email is already registered');
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure()
    : super(message: 'Incorrect email or password');
}

class AccountExistsWithDifferentCredentialFailure extends Failure {
  const AccountExistsWithDifferentCredentialFailure()
    : super(message: 'Account already exists with a different sign-in method');
}
