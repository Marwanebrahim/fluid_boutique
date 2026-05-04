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

  // ─── helper: كل Firestore operations في مكان واحد ───────────────────────────

  CollectionReference get _usersCollection =>
      db.collection(AppString.usersCollection);

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
      final uid = userCredential.user!.uid;
      final user = UserModel(
        email: email,
        name: name,
        photoUrl: null,
        uid: uid,
      );
      final userData = user.toMap();
      await _usersCollection.doc(uid).set(userData);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        default:
          throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // ─── logInWithEmail ──────────────────────────────────────────────────────────

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
      final uid = userCredential.user!.uid;

      final docSnapshot = await _usersCollection.doc(uid).get();
      if (!docSnapshot.exists) {
        final user = UserModel(
          email: email,
          name: userCredential.user!.displayName!,
          photoUrl: userCredential.user!.photoURL,
          uid: uid,
        );
        final userData = user.toMap();
        await _usersCollection.doc(uid).set(userData);
        return user;
      }
      return UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw InvalidCredentialsException();
        default:
          throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // ─── logInWithGoogle ─────────────────────────────────────────────────────────

  @override
  Future<UserModel> logInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      final docSnapshot = await _usersCollection
          .doc(userCredential.user!.uid)
          .get();
      if (!docSnapshot.exists) {
        final user = UserModel(
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName!,
          photoUrl: userCredential.user!.photoURL,
          uid: userCredential.user!.uid,
        );
        final userData = user.toMap();
        await _usersCollection
            .doc(userCredential.user!.uid)
            .set(userData, SetOptions(merge: true));
        return user;
      }
      return UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw AccountExistsWithDifferentCredentialException();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
