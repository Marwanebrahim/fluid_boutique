import 'package:fluid_boutique/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:fluid_boutique/features/profile/domain/use_case/log_out_use_case.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_state.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogOutUseCase logOutUseCase;

  ProfileBloc({required this.getProfileUseCase, required this.logOutUseCase})
    : super(ProfileInitialState()) {
    on<GetProfileEvent>(_onGetProfile);
    on<LogOutEvent>(_onLogOut);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await getProfileUseCase();
    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.message)),
      (profile) => emit(ProfileSuccessState(profile: profile)),
    );
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<ProfileState> emit) async {
    emit(LogOutLoadingState());
    final result = await logOutUseCase();
    result.fold(
      (failure) => emit(LogOutErrorState(message: failure.message)),
      (_) => emit(LogOutSuccessState()),
    );
  }
}
