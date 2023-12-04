import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.createdAt,
    required super.email,
    required super.token,
    required super.password,
    required super.id,
  });

  factory UserModel.fromJson(final Map<String, dynamic> json) {
    return UserModel(
      createdAt: DateTime.parse(json['createdAt']),
      email: json['email'],
      token: json['token'],
      password: json['password'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'email': email,
      'token': token,
      'password': password,
      'id': id,
    };
  }
}
