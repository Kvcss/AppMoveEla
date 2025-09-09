// lib/data/repositories/auth_repository_firebase.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryFirebase implements AuthRepository {
  AuthRepositoryFirebase({
    required fb.FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _google = googleSignIn;

  final fb.FirebaseAuth _auth;
  final GoogleSignIn _google;

  domain.User _toDomain(fb.User u) => domain.User(
    id: u.uid,
    name: u.displayName ?? '',
    email: u.email ?? '',
  );

  @override
  Future<(domain.User, String)> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final u = cred.user!;
      final String? token = await u.getIdToken(true);
      if (token == null || token.isEmpty) {
        throw Exception('Falha ao obter token de sessão.');
      }
      return (_toDomain(u), token);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  @override
  Future<(domain.User, String)> signInWithGoogle() async {
    try {
      fb.UserCredential cred;

      if (kIsWeb) {
        // Web: popup direto do Firebase Auth
        final provider = fb.GoogleAuthProvider();
        cred = await _auth.signInWithPopup(provider);
      } else {
        // Mobile (Android/iOS): google_sign_in + credencial
        final GoogleSignInAccount? gUser = await _google.signIn();
        if (gUser == null) throw Exception('Autenticação cancelada.');
        final gAuth = await gUser.authentication;
        final oauth = fb.GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        cred = await _auth.signInWithCredential(oauth);
      }

      final u = cred.user!;
      final String? token = await u.getIdToken(true);
      if (token == null || token.isEmpty) {
        throw Exception('Falha ao obter token de sessão.');
      }
      return (_toDomain(u), token);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _google.signOut(); // no web não faz mal chamar
      await _auth.signOut();
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  String _mapAuthError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'user-not-found':
      case 'wrong-password':
        return 'Credenciais inválidas.';
      case 'user-disabled':
        return 'Usuário desabilitado.';
      case 'network-request-failed':
        return 'Sem conexão. Tente novamente.';
      case 'account-exists-with-different-credential':
        return 'Já existe conta com outro método.';
      case 'popup-closed-by-user':
        return 'Autenticação cancelada.';
      default:
        return 'Falha na autenticação (${e.code}).';
    }
  }
}
