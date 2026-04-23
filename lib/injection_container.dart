import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_boutique/core/helpers/hive_helper.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:fluid_boutique/firebase_options.dart';
import 'package:get_it/get_it.dart';

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
}
