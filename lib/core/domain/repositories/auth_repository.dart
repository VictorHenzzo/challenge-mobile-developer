import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';

abstract class AuthRepository {
  Future<Either<AppError, UserEntity>> signIn({
    required final String email,
    required final String password,
  });
}
