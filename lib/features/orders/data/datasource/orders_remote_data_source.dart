import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/orders/data/model/order_model.dart';

// orders_remote_data_source.dart
abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getUserOrders();
  Future<void> placeOrder({required OrderModel order});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  OrdersRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  Future<String> getUserId() async => firebaseAuth.currentUser!.uid;

  // ✅ subcollection بدل document واحد
  CollectionReference _userOrdersCollection(String uId) => firestore
      .collection(AppString.ordersCollection)
      .doc(uId)
      .collection('userOrders');

  @override
  Future<List<OrderModel>> getUserOrders() async {
    try {
      final uId = await getUserId();
      final snapshot = await _userOrdersCollection(uId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) =>
              OrderModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> placeOrder({required OrderModel order}) async {
    try {
      final uId = await getUserId();
      final modifiedOrder = order.copyWith(userId: uId);

      // ✅ كل أوردر document مستقل — استخدم .doc(id).set() بدل merge على map
      await _userOrdersCollection(uId)
          .doc(modifiedOrder.id)
          .set(modifiedOrder.toMap());
    } catch (e) {
      throw ServerException();
    }
  }
}