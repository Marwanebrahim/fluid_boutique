import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });
  Future<UserModel> logInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> logInWithGoogle();
  Future<void> logOut();
}

class AuthRemoteDataSourceImplWithFireBase implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final GoogleSignIn googleSignIn;
  AuthRemoteDataSourceImplWithFireBase({
    required this.auth,
    required this.db,
    required this.googleSignIn,
  });
  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await db
          .collection(AppString.usersCollection)
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'email': email,
            'name': name,
            'photoUrl': null,
          });
      return UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        photoUrl: null,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await db
          .collection(AppString.usersCollection)
          .doc(userCredential.user!.uid)
          .get();
      final UserModel user = UserModel.fromMap(userData.data()!);
      return user;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> logInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final userData = await db
          .collection(AppString.usersCollection)
          .doc(userCredential.user!.uid)
          .get();
      final UserModel user = UserModel.fromMap(userData.data()!);
      return user;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw ServerException();
    }
  }
}
