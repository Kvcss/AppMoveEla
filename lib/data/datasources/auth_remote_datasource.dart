import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../models/auth_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseDto> signIn({required String email, required String password});
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);
  final ApiClient _client;


  @override
  Future<AuthResponseDto> signIn({required String email, required String password}) async {
    final Response resp = await _client.dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return AuthResponseDto.fromJson(resp.data as Map<String, dynamic>);
  }
}