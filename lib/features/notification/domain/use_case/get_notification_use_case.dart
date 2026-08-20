import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';
import 'package:fluid_boutique/features/notification/domain/repository/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository notificationsRepository;
  GetNotificationsUseCase({required this.notificationsRepository});

  Future<Either<Failure, List<NotificationEntity>>> call()async {
    return await notificationsRepository.getNotifications();
  }
}
