import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:veggies/services/auth/get_current_user.dart';
import 'package:veggies/services/auth/sign_out.dart';
import 'package:veggies/services/auth/sign_up_with_email.dart';

import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/implementaionts/auth_repository_impl.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'services/auth/sign_in_with_email.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Bloc
  getIt.registerFactory(
    () => AuthBloc(
      signInWithEmail: getIt(),
      signOut: getIt(),
      signUpWithEmail: getIt(),
      getCurrentUser: getIt(),
    ),
  );

  // services
  getIt.registerLazySingleton(() => SignInWithEmail(getIt()));
  getIt.registerLazySingleton(() => SignUpWithEmail(getIt()));
  getIt.registerLazySingleton(() => SignOut(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl.new,
  );

  // External
  getIt.registerLazySingleton(Dio.new);
}
