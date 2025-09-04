import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../di/injector.dart';
import '../router/route_names.dart';
import '../../presentation/views/splash/splash_view.dart';
import '../../presentation/viewmodels/splash_viewmodel.dart';
import '../../presentation/views/auth/login_view.dart';
import '../../presentation/viewmodels/login_viewmodel.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    // refreshListenable: getIt<AuthService>(),   // ← deixe comentado
    // redirect: (context, state) { ... },        // ← deixe comentado

    routes: [
      GoRoute(
        path: RouteNames.splash,
        pageBuilder: (ctx, st) => MaterialPage(
          child: ChangeNotifierProvider(
            create: (_) => getIt<SplashViewModel>(),
            child: const SplashView(),
          ),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        pageBuilder: (ctx, st) => MaterialPage(
          child: ChangeNotifierProvider(
            create: (_) => getIt<LoginViewModel>(),
            child: const LoginView(),
          ),
        ),
      ),
    ],
  );
}
