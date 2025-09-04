


import '../../domain/entities/user.dart';

class AuthResponseDto {
  final String token;
  final Map<String, dynamic> user;


  AuthResponseDto({required this.token, required this.user});


  factory AuthResponseDto.fromJson(Map<String, dynamic> json) => AuthResponseDto(
    token: json['token'] as String,
    user: (json['user'] as Map<String, dynamic>),
  );


  User toEntity() => User(
    id: user['id']?.toString() ?? '',
    name: user['name']?.toString() ?? '',
    email: user['email']?.toString() ?? '',
  );
}