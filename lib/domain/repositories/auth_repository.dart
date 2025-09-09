import '../entities/user.dart';

abstract class AuthRepository {
  Future<(User user, String idToken)> signIn({required String email, required String password});
  Future<(User user, String idToken)> signInWithGoogle();
  Future<void> sendPasswordReset({required String email});
  Future<void> signOut();
}
