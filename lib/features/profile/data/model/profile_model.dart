class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  const ProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });
}
