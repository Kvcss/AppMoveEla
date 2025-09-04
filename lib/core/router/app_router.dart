import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_ela/core/router/route_names.dart';
import 'package:provider/provider.dart';
import '../../domain/services/auth_service.dart';
import '../../presentation/viewmodels/login_viewmodel.dart';
import '../../presentation/viewmodels/splash_viewmodel.dart';
import '../../presentation/views/auth/login_view.dart';
import '../../presentation/views/splash/splash_view.dart';
import '../di/injector.dart';


class AppRouter {
  AppRouter._();
  static final AppRouter instance = AppRouter._();


  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: getIt<AuthService>(),
    redirect: (context, state) {
      final auth = getIt<AuthService>();
      final loggingIn = state.matchedLocation == RouteNames.login;
      if (!auth.isAuthenticated && !loggingIn && state.matchedLocation != RouteNames.splash) {
        return RouteNames.login;
      }
      if (auth.isAuthenticated && loggingIn) {
        return RouteNames.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        pageBuilder: (ctx, st) => MaterialPage(
          child: ChangeNotifierProvider(
            create: (_) => getIt<SplashViewModel>()..init(ctx),
            child: const SplashView(),
          ),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (ctx, st) => MaterialPage(
          child: ChangeNotifierProvider(
            create: (_) => getIt<LoginViewModel>(),
            child: const LoginView(),
          ),
        ),
      ),
// GoRoute(path: RouteNames.home, builder: ...), // TODO futura Home
    ],
  );
}