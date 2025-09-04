import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_names.dart';
import '../../domain/services/auth_service.dart';


class SplashViewModel extends ChangeNotifier {
  SplashViewModel(this._authService);
  final AuthService _authService;


  Future<void> init(BuildContext context) async {
    await _authService.loadSession();
    await Future.delayed(const Duration(milliseconds: 600));
    if (_authService.isAuthenticated) {
      context.go(RouteNames.home);
    } else {
      context.go(RouteNames.login);
    }
  }
}