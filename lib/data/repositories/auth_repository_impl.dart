import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;


  @override
  Future<(User user, String token)> signIn({required String email, required String password}) async {
    final dto = await _remote.signIn(email: email, password: password);
    final user = dto.toEntity();
    return (user, dto.token);
  }
}