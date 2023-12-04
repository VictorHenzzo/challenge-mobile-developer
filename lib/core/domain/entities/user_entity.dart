import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.createdAt,
    required this.email,
    required this.token,
    required this.password,
    required this.id,
  });

  final DateTime createdAt;
  final String email;
  final String token;
  final String password;
  final String id;

  @override
  List<Object?> get props => [
        createdAt,
        email,
        token,
        password,
        id,
      ];
}
