import 'package:fluid_boutique/core/helpers/hive_helper.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_local_data_source.dart';
import 'package:fluid_boutique/features/app/data/datasource/app_remote_data_source.dart';
import 'package:fluid_boutique/features/app/data/repository/app_repository.dart';
import 'package:fluid_boutique/features/app/presentation/bloc/app_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // app features
  await HiveHelper.init();
  sl.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImplWithHive(),
  );
  sl.registerLazySingleton<AppRemoteDataSource>(
    () => AppRemoteDataSourceImplWithFireBase(),
  );
  sl.registerLazySingleton<AppRepository>(
    () =>
        AppRepositoryImpl(appLocalDataSource: sl(), appRemoteDataSource: sl()),
  );
  sl.registerFactory<AppBloc>(() => AppBloc(appRepository: sl()));
}
