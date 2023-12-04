import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';

abstract class SignInUseCase {
  Future<Either<AppError, UserEntity>> signIn({
    required final String email,
    required final String password,
  });
}

final class SignInUseCaseImpl implements SignInUseCase {
  SignInUseCaseImpl(this.repository);

  final UserRepository repository;

  @override
  Future<Either<AppError, UserEntity>> signIn({
    required final String email,
    required final String password,
  }) {
    return repository.signIn(email: email, password: password);
  }
}
