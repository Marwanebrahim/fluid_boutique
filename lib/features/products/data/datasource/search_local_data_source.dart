import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/error/exeptions.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> addSearchHistory(String query);
  Future<List<String>> getSearchHistory();
  Future<void> clearSearchHistory();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  @override
  Future<List<String>> addSearchHistory(String query) async {
    try {
      final List<dynamic> response = Hive.box(
        AppString.searchHistoryBoxName,
      ).get(AppString.searchHistoryKey, defaultValue: []);
      final List<String> searchHistory = List.castFrom(response);
      searchHistory.add(query);
      await Hive.box(
        AppString.searchHistoryBoxName,
      ).put(AppString.searchHistoryKey, searchHistory);
      return searchHistory;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      final raw = Hive.box(
        AppString.searchHistoryBoxName,
      ).get(AppString.searchHistoryKey, defaultValue: []);
      final List<String> searchHistory = List<String>.from(raw);
      return searchHistory;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      await Hive.box(
        AppString.searchHistoryBoxName,
      ).put(AppString.searchHistoryKey, []);
    } catch (e) {
      throw CacheException();
    }
  }
}
