import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/implementaionts/auth_repository_impl.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'services/auth_services.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Bloc
  getIt.registerFactory(
    () => AuthBloc(
      authService: getIt<IAuthService>(),
    ),
  );

  // services
  getIt.registerLazySingleton<IAuthService>(() => AuthService(getIt()));

  // Repository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<IAuthRemoteDataSource>(AuthRemoteDataSource.new,
  );

  // External
  getIt.registerLazySingleton(Dio.new);
}
