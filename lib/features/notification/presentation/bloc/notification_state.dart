import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';

abstract class NotificationsState extends Equatable {}

class NotificationsInitialState extends NotificationsState {
  @override
  List<Object?> get props => [];
}

class NotificationsLoadingState extends NotificationsState {
  @override
  List<Object?> get props => [];
}

class NotificationsSuccessState extends NotificationsState {
  final List<NotificationEntity> notifications;
  NotificationsSuccessState({required this.notifications});

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  List<Object?> get props => [notifications];
}

class NotificationsEmptyState extends NotificationsState {
  @override
  List<Object?> get props => [];
}

class NotificationsErrorState extends NotificationsState {
  final String message;
  NotificationsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotificationsMarkAsReadState extends NotificationsState {
  @override
  List<Object?> get props => [];
}

class NotificationsMarkAllAsReadState extends NotificationsState {
  @override
  List<Object?> get props => [];
}
