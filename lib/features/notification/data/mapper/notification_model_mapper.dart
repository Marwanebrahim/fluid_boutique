import 'package:fluid_boutique/features/notification/data/model/notification_model.dart';
import 'package:fluid_boutique/features/notification/domain/entity/notification_entity.dart';

extension NotificationModelMapper on NotificationModel {
  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    title: title,
    body: body,
    type: type,
    imageUrl: imageUrl,
    isRead: isRead,
    createdAt: createdAt,
  );
}
