import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/auth_repository_firebase.dart';
import '../../domain/services/auth_service.dart';
import '../../presentation/viewmodels/login_viewmodel.dart';
import '../../presentation/viewmodels/splash_viewmodel.dart';
import '../storage/secure_storage_service.dart';
import '../utils/app_logger.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  getIt.registerLazySingleton<AppLogger>(() => AppLogger());
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  // Firebase SDKs
  getIt.registerLazySingleton<fb.FirebaseAuth>(() => fb.FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(scopes: const ['email', 'profile']));

  // Repository -> Firebase
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryFirebase(auth: getIt<fb.FirebaseAuth>(), googleSignIn: getIt<GoogleSignIn>()));

  // Service
  getIt.registerLazySingleton<AuthService>(() => AuthService(
    repository: getIt<AuthRepository>(),
    secureStorage: getIt<SecureStorageService>(),
  ));

  // ViewModels
  getIt.registerFactory<SplashViewModel>(() => SplashViewModel(getIt<AuthService>()));
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
    authRepository: getIt<AuthRepository>(),
    authService: getIt<AuthService>(),
  ));
}
