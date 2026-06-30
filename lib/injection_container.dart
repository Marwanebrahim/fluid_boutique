import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/helpers/hive_helper.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:fluid_boutique/features/auth/data/repositories/auth_repository.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/cart/data/datasource/cart_remote_data_source.dart';
import 'package:fluid_boutique/features/cart/data/repository/cart_repository_imp.dart';
import 'package:fluid_boutique/features/cart/domain/repository/cart_repository.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/get_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fluid_boutique/features/orders/data/datasource/orders_remote_data_source.dart';
import 'package:fluid_boutique/features/orders/data/repository/orders_repository_imp.dart';
import 'package:fluid_boutique/features/orders/domain/repository/order_repository.dart';
import 'package:fluid_boutique/features/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:fluid_boutique/features/orders/domain/use_case/place_order_use_case.dart';
import 'package:fluid_boutique/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:fluid_boutique/features/products/data/datasource/product_remote_data_source.dart';
import 'package:fluid_boutique/features/products/data/datasource/search_local_data_source.dart';
import 'package:fluid_boutique/features/products/data/repository/product_repository_imp.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/add_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/clear_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_all_categories_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_all_products_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/search_product_use_case.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:fluid_boutique/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:fluid_boutique/features/profile/data/repository/profile_repository_imp.dart';
import 'package:fluid_boutique/features/profile/domain/repository/profile_repository.dart';
import 'package:fluid_boutique/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:fluid_boutique/features/profile/domain/use_case/log_out_use_case.dart';
import 'package:fluid_boutique/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:fluid_boutique/features/wishlist/data/datasource/wishlist_remote_data_source.dart';
import 'package:fluid_boutique/features/wishlist/data/repository/wishlist_repository_imp.dart';
import 'package:fluid_boutique/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/add_to_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/get_product_data_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/get_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/remove_from_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // app features
  await HiveHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sl.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImplWithHive(),
  );
  sl.registerLazySingleton<AppRemoteDataSource>(
    () => AppRemoteDataSourceImplWithFireBase(auth: FirebaseAuth.instance),
  );
  sl.registerLazySingleton<AppRepository>(
    () =>
        AppRepositoryImpl(appLocalDataSource: sl(), appRemoteDataSource: sl()),
  );
  sl.registerFactory<AppBloc>(() => AppBloc(appRepository: sl()));

  /// auth features
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
  await sl<GoogleSignIn>().initialize();
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplWithFireBase(
      auth: sl(),
      db: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepository: sl()));

  /// products features
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppString.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(
      productRemoteDataSource: sl(),
      searchLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(productRepository: sl()),
  );
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(productRepository: sl()),
  );
  sl.registerLazySingleton<SearchProductUseCase>(
    () => SearchProductUseCase(productRepository: sl()),
  );
  sl.registerLazySingleton<GetSearchHistoryUseCase>(
    () => GetSearchHistoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddSearchHistoryUseCase>(
    () => AddSearchHistoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<ClearSearchHistoryUseCase>(
    () => ClearSearchHistoryUseCase(repository: sl()),
  );
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      getAllCategoriesUseCase: sl(),
      getAllProductsUseCase: sl(),
      getProductsByCategoryUseCase: sl(),
    ),
  );

  sl.registerFactory<SearchBloc>(
    () => SearchBloc(
      searchProductUseCase: sl(),
      getSearchHistoryUseCase: sl(),
      addSearchHistoryUseCase: sl(),
      clearSearchHistoryUseCase: sl(),
    ),
  );

  /// wishlist features
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImp(
      firebaseFirestore: sl(),
      firebaseAuth: sl(),
      dio: sl(),
    ),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImp(remoteWishlistDataSource: sl()),
  );
  sl.registerLazySingleton<GetWishlistUseCase>(
    () => GetWishlistUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddToWishlistUseCase>(
    () => AddToWishlistUseCase(wishlistRepository: sl()),
  );
  sl.registerLazySingleton<RemoveFromWishlistUseCase>(
    () => RemoveFromWishlistUseCase(wishlistRepository: sl()),
  );
  sl.registerLazySingleton<GetProductDataUseCase>(
    () => GetProductDataUseCase(wishlistRepository: sl()),
  );
  sl.registerFactory<WishlistBloc>(
    () => WishlistBloc(
      getWishlistUseCase: sl(),
      addToWishlistUseCase: sl(),
      removeFromWishlistUseCase: sl(),
      getProductDataUseCase: sl(),
    ),
  );

  /// cart features
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(firebaseFirestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImp(cartRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(cartRepository: sl()),
  );
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(cartRepository: sl()),
  );
  sl.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(cartRepository: sl()),
  );
  sl.registerLazySingleton<ClearCartUseCase>(
    () => ClearCartUseCase(cartRepository: sl()),
  );

  sl.registerFactory<CartBloc>(
    () => CartBloc(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      clearCartUseCase: sl(),
    ),
  );

  /// Orders
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(ordersRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetUserOrdersUseCase>(
    () => GetUserOrdersUseCase(ordersRepository: sl()),
  );
  sl.registerLazySingleton<PlaceOrderUseCase>(
    () => PlaceOrderUseCase(ordersRepository: sl()),
  );
  sl.registerFactory<OrdersBloc>(
    () => OrdersBloc(getUserOrdersUseCase: sl(), placeOrderUseCase: sl()),
  );

  /// Profile feature
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(), 
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(profileRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(profileRepository: sl()),
  );
  sl.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(profileRepository: sl()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(getProfileUseCase: sl(), logOutUseCase: sl()),
  );
}
