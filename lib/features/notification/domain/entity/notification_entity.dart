class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String type; 
  final String? imageUrl;
  final bool isRead;
  final DateTime createdAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.imageUrl,
    required this.isRead,
    required this.createdAt,
  });

  NotificationEntity copyWith({bool? isRead}) => NotificationEntity(
        id: id,
        title: title,
        body: body,
        type: type,
        imageUrl: imageUrl,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
      );
}