import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';

abstract class AppRemoteDataSource {
  Future<bool> isLoggedIn();
}

class AppRemoteDataSourceImplWithFireBase implements AppRemoteDataSource {
  final FirebaseAuth auth;
  AppRemoteDataSourceImplWithFireBase({required this.auth});
  @override
  Future<bool> isLoggedIn() {
    try {
      return Future.value(auth.currentUser != null);
    } catch (e) {
      throw ServerException();
    }
  }
}
