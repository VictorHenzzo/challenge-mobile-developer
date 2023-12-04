import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late SignInUseCase sut;
  late _UserRepositorySpy repository;

  late String password;
  late String email;
  late UserEntity user;

  setUp(() {
    repository = _UserRepositorySpy();
    sut = SignInUseCaseImpl(repository);

    password = 'password';
    email = 'email@mail.example';
    user = UserModel.empty();
  });

  test('Should be able to call repository with the correct values', () async {
    // arrange
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => Success(user));

    // act
    await sut.signIn(email: email, password: password);

    // assert
    verify(
      () => repository.signIn(
        email: email,
        password: password,
      ),
    ).called(1);
  });

  test('Should be able to return a UserEntity on success', () async {
    // arrange
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => Success(user));

    // act
    final result = await sut.signIn(
      email: email,
      password: password,
    );

    // assert
    expect(result.valueOrNull, user);
  });

  test('Should be able to return a AppError on failure', () async {
    // arrange
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => Failure(AppError.empty()));

    // act
    final result = await sut.signIn(
      email: email,
      password: password,
    );

    // assert
    expect(result.errorOrNull, isA<AppError>());
  });
}

class _UserRepositorySpy extends Mock implements UserRepository {}
