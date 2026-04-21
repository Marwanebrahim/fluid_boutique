sealed class AppEvent {}

class IsLoggedInEvent extends AppEvent {}

class IsSeenOnBoardingEvent extends AppEvent {}

class SetSeenOnBoardingEvent extends AppEvent {
  final bool isSeen;
  SetSeenOnBoardingEvent({required this.isSeen});
}
