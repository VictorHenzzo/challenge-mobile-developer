import 'package:challenge_mobile_developer/core/data/repositories/user_repository_impl.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  UserRepository authRepository(
    final UserRepositoryImpl repository,
  ) =>
      repository;

  SignInUseCase signInUseCase(
    final SignInUseCaseImpl useCase,
  ) =>
      useCase;

  CheckAuthStateUseCase checkAuthStateUseCase(
    final CheckAuthStateUseCaseImpl useCase,
  ) =>
      useCase;
}
