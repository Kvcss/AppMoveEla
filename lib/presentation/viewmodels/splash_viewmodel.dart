import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/route_names.dart';
import '../../domain/services/auth_service.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel(this._auth);
  final AuthService _auth;

  Future<void> init(BuildContext context) async {
    await _auth.loadSession();
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    context.go(RouteNames.login);
  }
}
