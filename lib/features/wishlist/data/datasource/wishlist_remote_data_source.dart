import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/products/data/model/product_model.dart';
import 'package:fluid_boutique/features/wishlist/data/model/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<bool> addToWishlist(WishlistModel productId);
  Future<bool> removeFromWishlist(int productId);
  Future<List<WishlistModel>> getWishlist();
  Future<ProductModel> getProductData(int productId);
}

class WishlistRemoteDataSourceImp implements WishlistRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final Dio _dio;
  WishlistRemoteDataSourceImp({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required Dio dio,
  }) : _dio = dio;
  CollectionReference get _usersCollection =>
      firebaseFirestore.collection(AppString.whishListCollection);

  @override
  Future<bool> addToWishlist(WishlistModel product) async {
    try {
      final uId = await getUserId();
      await _usersCollection.doc(uId).set({
        product.id.toString(): product.toJson(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<WishlistModel>> getWishlist() async {
    try {
      final uId = await getUserId();
      final docSnapshot = await _usersCollection.doc(uId).get();
      if (!docSnapshot.exists) return [];
      final wishlistData = docSnapshot.data() as Map<String, dynamic>;
      final wishlist = wishlistData.entries
          .map((e) => WishlistModel.fromJson(e.value))
          .toList();
      return wishlist;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeFromWishlist(int productId) async {
    try {
      final uId = await getUserId();
      await _usersCollection.doc(uId).update({
        productId.toString(): FieldValue.delete(),
      });
      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<String> getUserId() async => firebaseAuth.currentUser!.uid;

  @override
  Future<ProductModel> getProductData(int productId) async {
    try {
      final result = await _dio.get("${AppString.productsPath}/$productId/");
      final response = result.data as Map<String, dynamic>;
      final products = ProductModel.fromJson(json: response);
      return products;
    } catch (e) {
      throw ServerException();
    }
  }
}
