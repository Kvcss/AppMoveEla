import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_names.dart';
import '../../core/utils/validators.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';
import '../widgets/login/app_error_popup.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository authRepository,
    required AuthService authService,
  })  : _authRepository = authRepository,
        _authService = authService;

  final AuthRepository _authRepository;
  final AuthService _authService;

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();
  final emailFocus = FocusNode();
  final passFocus  = FocusNode();

  // estado
  String _email = '';
  String _password = '';
  bool _obscure = true;
  bool _loading = false;

  // erros de campo
  String? emailError;
  String? passwordError;

  bool get loading => _loading;
  bool get obscure => _obscure;

  void onEmailChanged(String v) {
    _email = v.trim();
    if (emailError != null) { emailError = null; notifyListeners(); }
  }

  void onPasswordChanged(String v) {
    _password = v;
    if (passwordError != null) { passwordError = null; notifyListeners(); }
  }

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  bool _validateFields() {
    bool ok = true;

    if (!Validators.isValidEmail(_email)) {
      emailError = 'Insira um e-mail válido.';
      ok = false;
    }
    if (!Validators.isValidPassword(_password)) {
      passwordError = 'Senha muito curta.';
      ok = false;
    }

    if (!ok) {
      notifyListeners();
      // foca no primeiro com erro
      if (emailError != null) {
        emailFocus.requestFocus();
      } else if (passwordError != null) {
        passFocus.requestFocus();
      }
    }
    return ok;
  }

  Future<void> submit(BuildContext context) async {
    // validação local com UI (borda vermelha + foco + texto)
    if (!_validateFields()) return;

    _loading = true;
    notifyListeners();
    try {
      await _authService.login(_email, _password);
      if (context.mounted) context.go(RouteNames.home); // TODO: Home real
    } catch (e) {
      // Erro vindo do Firebase → popup bonito
      if (context.mounted) {
        await showErrorPopup(
          context,
          title: 'Falha no login',
          message: _prettyError(e),
        );
      }
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
    } catch (e) {
      if (context.mounted) {
        await showErrorPopup(
          context,
          title: 'Account failed',
          message: _prettyError(e),
        );
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPassword() async {
    if (!Validators.isValidEmail(_email)) {
      emailError = 'Insira um e-mail válido para recuperar.';
      notifyListeners();
      emailFocus.requestFocus();
      throw Exception('Informe um e-mail válido para recuperar a senha.');
    }
    await _authService.sendPasswordReset(_email);
  }

  String _prettyError(Object e) {
    final s = e.toString();

    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }
}
