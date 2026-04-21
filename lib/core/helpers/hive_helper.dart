import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(AppString.utilsBoxName);
  }
}
