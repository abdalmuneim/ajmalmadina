import 'package:butcity/features/auth_feature/data/data_sources/auth_local_data_source.dart';
import 'package:butcity/features/auth_feature/data/data_sources/auth_remote_data_source.dart';
import 'package:butcity/features/auth_feature/data/repositories/auth_repository.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/login_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/logout_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/register_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/update_user_use_case.dart';
import 'package:butcity/features/compilations/data/datasources/compliation_data_source.dart';
import 'package:butcity/features/compilations/data/repositories/compilations_repository_impl.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:butcity/features/compilations/domain/usecases/get_compilation_type_use_case.dart';
import 'package:butcity/features/compilations/domain/usecases/get_compilations_use_case.dart';
import 'package:butcity/features/compilations/domain/usecases/new_compilation_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///-------------- Auth FEATURE -----------------------
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => GetCompilationsUseCase(sl()));
  sl.registerLazySingleton(() => NewCompilationsUseCase(sl()));
  sl.registerLazySingleton(() => GetCompilationTypeUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(baseAuthRepository: sl()));

  // Repository
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRespoitory(
        baseAuthRemoteDataSource: sl(),
        baseAuthLocalDataSource: sl(),
        networkInfo: sl()),
  );

  sl.registerLazySingleton<CompilationRepository>(
    () => CompilationRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );
  sl.registerLazySingleton<CompilationDataSource>(
    () => CompilationDataSourceImpl(),
  );

  // Local sources
  sl.registerLazySingleton<BaseAuthLocalDataSource>(
    () => AuthLocalDataSource(
      getStorage: sl(),
      flutterSecureStorage: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //! External
  await GetStorage.init('AjmalMadinaFlutter');
  sl.registerLazySingleton(() => GetStorage('AjmalMadinaFlutter'));
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
}
