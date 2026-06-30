import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/notification/domain/repository/notification_repository.dart';

class MarkAllAsReadUseCase {
  final NotificationsRepository notificationsRepository;
  MarkAllAsReadUseCase({required this.notificationsRepository});

  Future<Either<Failure, Unit>> call() async {
    return await notificationsRepository.markAllAsRead();
  }
}
