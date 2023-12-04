import 'package:challenge_mobile_developer/core/data/repositories/auth_repository_impl.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  AuthRepository authRepository(
    final AuthRepositoryImpl repository,
  ) =>
      repository;

  SignInUseCase signInUseCase(
    final SignInUseCaseImpl useCase,
  ) =>
      useCase;
}
