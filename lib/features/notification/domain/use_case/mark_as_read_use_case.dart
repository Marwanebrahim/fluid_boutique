import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/notification/domain/repository/notification_repository.dart';

class MarkAsReadUseCase {
  final NotificationsRepository notificationsRepository;
  MarkAsReadUseCase({required this.notificationsRepository});

  Future<Either<Failure, Unit>> call(String notificationId)async {
    return await notificationsRepository.markAsRead(notificationId);
  }
}