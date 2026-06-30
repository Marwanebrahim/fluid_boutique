import 'package:fluid_boutique/features/notification/domain/use_case/get_notification_use_case.dart';
import 'package:fluid_boutique/features/notification/domain/use_case/mark_all_as_read_use_case.dart';
import 'package:fluid_boutique/features/notification/domain/use_case/mark_as_read_use_case.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_event.dart';
import 'package:fluid_boutique/features/notification/presentation/bloc/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
  }) : super(NotificationsInitialState()) {
    on<GetNotificationsEvent>(_onGetNotificationsEvent);
    on<MarkAsReadEvent>(_onMarkAsReadEvent);
    on<MarkAllAsReadEvent>(_onMarkAllAsReadEvent);
  }

  void _onGetNotificationsEvent(
    GetNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoadingState());
    final result = await getNotificationsUseCase();
    result.fold(
      (failure) => emit(NotificationsErrorState(message: failure.message)),
      (notifications) => emit(
        notifications.isEmpty
            ? NotificationsEmptyState()
            : NotificationsSuccessState(notifications: notifications),
      ),
    );
  }

  void _onMarkAsReadEvent(
    MarkAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoadingState());
    final result = await markAsReadUseCase(event.notificationId);
    result.fold(
      (failure) => emit(NotificationsErrorState(message: failure.message)),
      (success) => emit(NotificationsMarkAsReadState()),
    );
  }

  void _onMarkAllAsReadEvent(
    MarkAllAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoadingState());
    final result = await markAllAsReadUseCase();
    result.fold(
      (failure) => emit(NotificationsErrorState(message: failure.message)),
      (success) => emit(NotificationsMarkAllAsReadState()),
    );
  }
}
