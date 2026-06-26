import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/cart/data/model/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({required CartModel product});
  Future<void> removeFromCart({required int productId});
  Future<void> clearCart();
  Future<List<CartModel>> getCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  CartRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  CollectionReference get _usersCollection =>
      firebaseFirestore.collection(AppString.cartCollection);

  Future<String> getUserId() async => firebaseAuth.currentUser!.uid;

  @override
  Future<void> addToCart({required CartModel product}) async {
    try {
      final uId = await getUserId();
      await _usersCollection.doc(uId).set({
        product.id.toString(): product.toJson(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final uId = await getUserId();
      await _usersCollection.doc(uId).delete();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    try {
      final uId = await getUserId();
      final docSnapshot = await _usersCollection.doc(uId).get();
      if (!docSnapshot.exists) return [];
      final wishlistData = docSnapshot.data() as Map<String, dynamic>;
      final wishlist = wishlistData.entries
          .map((e) => CartModel.fromJson(e.value))
          .toList();
      return wishlist;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> removeFromCart({required int productId}) async {
    try {
      final uId = await getUserId();
      await _usersCollection.doc(uId).update({
        productId.toString(): FieldValue.delete(),
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
