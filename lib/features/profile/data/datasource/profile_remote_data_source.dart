import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:fluid_boutique/features/profile/data/model/profile_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> logOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  ProfileRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw ServerException();
      }
      return ProfileModel(
        uid: user.uid,
        name: user.displayName ?? 'Guest',
        email: user.email ?? '',
        photoUrl: user.photoURL,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerException();
    }
  }
}
