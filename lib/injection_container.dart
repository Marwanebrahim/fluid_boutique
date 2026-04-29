import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_boutique/core/helpers/hive_helper.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:fluid_boutique/features/auth/data/repositories/auth_repository.dart';
import 'package:fluid_boutique/features/auth/presentation/bloc/auth_bloc.dart';
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
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplWithFireBase(
      auth: sl(),
      db: sl(),
      googleSignIn: googleSignIn,
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepository: sl()));
}
