class AppString {
  /// Hive
  static const String utilsBoxName = "utils";
  static const String isLoggedInKey = "isLoggedIn";
  static const String isSeenOnboarding = "isSeenOnboarding";
  static const String searchHistoryBoxName = "search_history";
  static const String searchHistoryKey = "history";

  /// Firebase
  static const String usersCollection = "users";
  static const String whishListCollection = "wishlist";
  static const String cartCollection = "cart";
  static const String ordersCollection = "orders";

  /// Api endpoint
  static const String baseUrl = "https://dummyjson.com";

  ///endpoint path
  static const String productsPath = "/products";
  static const String categoriesPath = "$productsPath/categories";
  static const String categoryPath = "$productsPath/category";
  static const String searchPath = "$productsPath/search";
}
