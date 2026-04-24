class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  UserModel({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name, 'photoUrl': photoUrl, 'uid': uid};
  }
}
