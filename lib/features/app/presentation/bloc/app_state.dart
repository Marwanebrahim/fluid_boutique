sealed class AppState {}

class AppInitial extends AppState {}

class IsLoggedIn extends AppState {
  final bool isLoggedIn;
  IsLoggedIn({required this.isLoggedIn});
}

class IsSeenOnBoarding extends AppState {
  final bool isSeenOnBoarding;
  IsSeenOnBoarding({required this.isSeenOnBoarding});
}

class SeenOnBoardingSuccess extends AppState {}

class AppError extends AppState {
  final String message;
  AppError({required this.message});
}
