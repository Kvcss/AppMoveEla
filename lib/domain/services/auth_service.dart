import 'package:flutter/foundation.dart';

import '../../core/storage/secure_storage_service.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class AuthService extends ChangeNotifier {
  AuthService({required this.repository, required this.secureStorage});

  final AuthRepository repository;
  final SecureStorageService secureStorage;

  User? _currentUser;
  String? _token;

  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  User? get currentUser => _currentUser;

  Future<String?> getToken() async => _token ??= await secureStorage.readToken();

  Future<void> loadSession() async {
    _token = await secureStorage.readToken();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final (user, token) = await repository.signIn(email: email, password: password);
    _currentUser = user;
    _token = token;
    await secureStorage.saveToken(token);
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    final (user, token) = await repository.signInWithGoogle();
    _currentUser = user;
    _token = token;
    await secureStorage.saveToken(token);
    notifyListeners();
  }

  Future<void> sendPasswordReset(String email) async {
    await repository.sendPasswordReset(email: email);
  }

  Future<void> logout() async {
    await repository.signOut();
    _currentUser = null;
    _token = null;
    await secureStorage.clearToken();
    notifyListeners();
  }
}
