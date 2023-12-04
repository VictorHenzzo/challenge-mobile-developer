import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';

abstract class UserRepository {
  Future<Either<AppError, UserEntity>> signIn({
    required final String email,
    required final String password,
  });

  Future<Either<AppError, UserEntity?>> getUserFromLocal();

  Future<Either<AppError, UserEntity>> getUserById(
    final String id,
  );
}
