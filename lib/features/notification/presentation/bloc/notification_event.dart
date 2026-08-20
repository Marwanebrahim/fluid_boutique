import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {}

class GetNotificationsEvent extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class MarkAsReadEvent extends NotificationsEvent {
  final String notificationId;
  MarkAsReadEvent({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class MarkAllAsReadEvent extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}
