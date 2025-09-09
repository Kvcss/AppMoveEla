import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_names.dart';
import '../../core/utils/validators.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository authRepository,
    required AuthService authService,
  })  : _authRepository = authRepository,
        _authService = authService;

  final AuthRepository _authRepository;
  final AuthService _authService;

  String _email = '';
  String _password = '';
  bool _obscure = true;
  bool _loading = false;

  bool get loading => _loading;
  bool get obscure => _obscure;

  void onEmailChanged(String v) => _email = v.trim();
  void onPasswordChanged(String v) => _password = v;

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!Validators.isValidEmail(_email)) throw Exception('E-mail inválido');
    if (!Validators.isValidPassword(_password)) throw Exception('Senha muito curta');

    _loading = true;
    notifyListeners();
    try {
      await _authService.login(_email, _password);
      if (context.mounted) context.go(RouteNames.home); // TODO: definir Home
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    _loading = true;
    notifyListeners();
    try {
      await _authService.loginWithGoogle();
      if (context.mounted) context.go(RouteNames.home);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPassword() async {
    if (!Validators.isValidEmail(_email)) {
      throw Exception('Informe um e-mail válido para recuperar a senha.');
    }
    await _authService.sendPasswordReset(_email);
  }
}
