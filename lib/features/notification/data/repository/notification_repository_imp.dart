import 'package:dartz/dartz.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/core/error/failures.dart';
import 'package:fluid_boutique/features/notification/data/datasource/notification_remote_data_source.dart';
import 'package:fluid_boutique/features/notification/data/mapper/notification_model_mapper.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';
import 'package:fluid_boutique/features/notification/domain/repository/notification_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource notificationsRemoteDataSource;

  NotificationsRepositoryImpl({required this.notificationsRemoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final models = await notificationsRemoteDataSource.getNotifications();
      final notifications = models.map((e) => e.toEntity()).toList();
      return Right(notifications);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAsRead(String notificationId) async {
    try {
      await notificationsRemoteDataSource.markAsRead(notificationId);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAllAsRead() async {
    try {
      await notificationsRemoteDataSource.markAllAsRead();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
