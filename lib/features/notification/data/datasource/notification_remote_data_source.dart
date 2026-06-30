import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/notification/data/model/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  NotificationsRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String get _uId => firebaseAuth.currentUser!.uid;

  // ✅ subcollection لكل يوزر — نفس النمط اللي استخدمناه في Orders
  // users/{uId}/notifications/{notificationId}
  CollectionReference get _notificationsCollection =>
      firestore.collection('users').doc(_uId).collection('notifications');

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final snapshot = await _notificationsCollection
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map(
            (doc) => NotificationModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationsCollection.doc(notificationId).update({
        'isRead': true,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      final snapshot = await _notificationsCollection
          .where('isRead', isEqualTo: false)
          .get();

      // ✅ batch write — تحديث كل الـ unread في عملية واحدة
      final batch = firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } catch (e) {
      throw ServerException();
    }
  }
}
