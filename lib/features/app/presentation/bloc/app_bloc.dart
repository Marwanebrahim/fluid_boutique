import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/app%20strings/app_failures.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_event.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppRepository appRepository;
  AppBloc({required this.appRepository}) : super(AppInitial()) {
    on<IsLoggedInEvent>((event, emit) async {
      final result = await appRepository.isLoggedIn();
      emit(_mapFailureOrResultToStateOfIsLoggedIn(result));
    });

    on<IsSeenOnBoardingEvent>((event, emit) async {
      final result = await appRepository.isSeenOnBoarding();
      emit(_mapFailureOrResultToStateOfIsSeenOnBoarding(result));
    });

    on<SetSeenOnBoardingEvent>((event, emit) async {
      final result = await appRepository.setSeenOnBoarding(event.isSeen);
      result.fold(
        (failure) => emit(AppError(message: _mapFailureToMessage(failure))),
        (result) => emit(SeenOnBoardingSuccess()),
      );
    });
  }

  AppState _mapFailureOrResultToStateOfIsLoggedIn(
    Either<Failure, bool> either,
  ) {
    return either.fold(
      (failure) => AppError(message: _mapFailureToMessage(failure)),
      (result) => IsLoggedIn(isLoggedIn: result),
    );
  }

  AppState _mapFailureOrResultToStateOfIsSeenOnBoarding(
    Either<Failure, bool> either,
  ) {
    return either.fold(
      (failure) => AppError(message: _mapFailureToMessage(failure)),
      (result) => IsSeenOnBoarding(isSeenOnBoarding: result),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMassege;
      case const (CacheFailure):
        return cacheFailureMassege;
      default:
        return "Unexpected Error";
    }
  }
}
