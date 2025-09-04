
import '../entities/user.dart';


abstract class AuthRepository {
  Future<(User user, String token)> signIn({required String email, required String password});
}