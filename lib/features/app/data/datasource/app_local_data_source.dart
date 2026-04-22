import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AppLocalDataSource {
  Future<bool> isSeenOnBoarding();
  Future<void> setSeenOnBoarding(bool isSeen);
}

class AppLocalDataSourceImplWithHive implements AppLocalDataSource {
  @override
  Future<bool> isSeenOnBoarding() async {
    try {
      bool isSeenOnBoarding = Hive.box(
        AppString.utilsBoxName,
      ).get(AppString.isSeenOnboarding, defaultValue: false);
      return isSeenOnBoarding;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setSeenOnBoarding(bool isSeen) async {
    try {
      await Hive.box(
        AppString.utilsBoxName,
      ).put(AppString.isSeenOnboarding, isSeen);
    } catch (e) {
      throw CacheException();
    }
  }
}
