import 'package:fluid_boutique/features/profile/data/model/profile_model.dart';
import 'package:fluid_boutique/features/profile/domain/entity/profile_entity.dart';

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toEntity() =>
      ProfileEntity(uid: uid, name: name, email: email, photoUrl: photoUrl);
}
