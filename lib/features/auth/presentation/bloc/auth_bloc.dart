import 'package:fluid_boutique/features/auth/data/repositories/auth_repository.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_event.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<SignUpWithEmailEvent>(_onSignUpWithEmailEvent);
    on<LogInWithEmailEvent>(_onLogInWithEmailEvent);
    on<LogInWithGoogleEvent>(_onLogInWithGoogleEvent);
  }

  Future<void> _onSignUpWithEmailEvent(
    SignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.signUpWithEmail(
      email: event.email,
      password: event.password,
      name: event.name,
    );
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthSuccessState(user: user)),
    );
  }

  Future<void> _onLogInWithEmailEvent(
    LogInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.logInWithEmail(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthSuccessState(user: user)),
    );
  }

  Future<void> _onLogInWithGoogleEvent(
    LogInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.logInWithGoogle();
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthSuccessState(user: user)),
    );
  }
}
