import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_boutique/core/app%20strings/app_string.dart';
import 'package:fluid_boutique/core/helpers/hive_helper.dart';
import 'package:fluid_boutique/core/network/network_info.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:fluid_boutique/features/auth/data/repositories/auth_repository.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluid_boutique/features/products/data/datasource/product_remote_data_source.dart';
import 'package:fluid_boutique/features/products/data/repository/product_repository_imp.dart';
import 'package:fluid_boutique/features/products/domain/repository/product_repository.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_all_categories_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_all_products_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:fluid_boutique/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(connectionChecker: sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () =>
        ProductRepositoryImp(productRemoteDataSource: sl(), networkInfo: sl()),
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
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      getAllCategoriesUseCase: sl(),
      getAllProductsUseCase: sl(),
      getProductsByCategoryUseCase: sl(),
    ),
  );
}
