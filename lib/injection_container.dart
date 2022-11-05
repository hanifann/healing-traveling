import 'package:get_it/get_it.dart';
import 'package:healing_travelling/auth/bloc/auth_bloc.dart';
import 'package:healing_travelling/core/platform/network_info.dart';
import 'package:healing_travelling/login/data/datasource/user_local_data_source.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/data/repositories/user_repository_impl.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';
import 'package:healing_travelling/login/domain/usecase/fetch_user_data.dart';
import 'package:healing_travelling/login/domain/usecase/post_auth.dart';
import 'package:healing_travelling/login/presentation/bloc/login_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginBloc(postAuth: sl()));
  sl.registerFactory(() => AuthBloc(sl()));


  //usecase
  sl.registerLazySingleton(() => PostAuthData(sl()));
  sl.registerLazySingleton(() => FetchUserData(sl()));

  //repository
  sl.registerLazySingleton<UserRepository>(
    ()=> UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl())
  );

  //data source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl())
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl())
  );

  //!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!external
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}