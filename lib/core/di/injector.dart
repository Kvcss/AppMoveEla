import 'package:get_it/get_it.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';
import '../../presentation/viewmodels/login_viewmodel.dart';
import '../../presentation/viewmodels/splash_viewmodel.dart';
import '../network/api_client.dart';
import '../storage/secure_storage_service.dart';
import '../utils/app_logger.dart';



final getIt = GetIt.instance;


Future<void> configureDependencies() async {
// Core
  getIt.registerLazySingleton<AppLogger>(() => AppLogger());
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.exemplo.com'),
  ));


// Data
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt<ApiClient>()));


// Domain
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()));
  getIt.registerLazySingleton<AuthService>(() => AuthService(
    repository: getIt<AuthRepository>(),
    secureStorage: getIt<SecureStorageService>(),
  ));


// ViewModels (factory para instâncias novas por tela)
  getIt.registerFactory<SplashViewModel>(() => SplashViewModel(getIt<AuthService>()));
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
    authRepository: getIt<AuthRepository>(),
    authService: getIt<AuthService>(),
  ));
}