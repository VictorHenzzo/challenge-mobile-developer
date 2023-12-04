import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late CheckAuthStateUseCaseImpl sut;
  late UserRepositorySpy userRepository;

  late UserEntity user1;
  late UserEntity user2;

  setUp(() {
    userRepository = UserRepositorySpy();
    sut = CheckAuthStateUseCaseImpl(userRepository);

    user1 = UserEntity(
      createdAt: DateTime.parse('2023-11-02T18:54:47.981Z'),
      email: 'email1',
      token: 'token1',
      password: 'password1',
      id: 'id1',
    );

    user2 = UserEntity(
      createdAt: DateTime.parse('2023-11-02T18:54:47.981Z'),
      email: 'email2',
      token: 'token2',
      password: 'password2',
      id: 'id2',
    );
  });

  void mockGetUserFromLocal(final Either<AppError, UserEntity?> result) {
    when(userRepository.getUserFromLocal).thenAnswer(
      (final _) async => result,
    );
  }

  void mockGetUserById(final Either<AppError, UserEntity> result) {
    when(() => userRepository.getUserById(any())).thenAnswer(
      (final _) async => result,
    );
  }

  group("Won't have a local user", () {
    test('Should be able to call getUserFromLocal, without calling getUserById',
        () async {
      // arrange
      mockGetUserFromLocal(const Success(null));

      // act
      await sut.check();

      // assert
      verify(userRepository.getUserFromLocal).called(1);
      verifyNoMoreInteractions(userRepository);
    });

    test(
        'Should be able to return AuthState.none if getUserFromLocal returns null',
        () async {
      // arrange
      mockGetUserFromLocal(const Success(null));

      // act
      final result = await sut.check();

      // assert
      expect(result, AuthState.none);
    });
  });

  group('Have a local user', () {
    test(
        'Should be able to call getUserFromLocal, and then getUserFrom remote with the correct values',
        () async {
      // arrange
      mockGetUserFromLocal(Success(user1));
      mockGetUserById(Success(user2));

      // act
      await sut.check();

      // assert
      verifyInOrder([
        () => userRepository.getUserFromLocal(),
        () => userRepository.getUserById(user1.id),
      ]);
    });

    test(
        'Should return AuthState.authenticated if local and remote user are equal',
        () async {
      // arrange
      mockGetUserFromLocal(Success(user1));
      mockGetUserById(Success(user1));

      // act
      final result = await sut.check();

      // assert
      expect(result, AuthState.authenticated);
    });

    test(
        'Should return AuthState.authenticated if the local and remote users are different',
        () async {
      // arrange
      mockGetUserFromLocal(Success(user1));
      mockGetUserById(Success(user2));

      // act
      final result = await sut.check();

      // assert
      expect(result, AuthState.none);
    });

    test(
        'Should return AuthState.none if getUserFromLocal returns error, without calling getUserById',
        () async {
      // arrange
      mockGetUserFromLocal(Failure(AppError.empty()));

      // act
      final result = await sut.check();

      // assert
      expect(result, AuthState.none);

      verify(userRepository.getUserFromLocal).called(1);
      verifyNoMoreInteractions(userRepository);
    });

    test('Should return AuthState.none if getUserById returns error', () async {
      // arrange
      mockGetUserFromLocal(Success(user1));
      mockGetUserById(Failure(AppError.empty()));

      // act
      final result = await sut.check();

      // assert
      expect(result, AuthState.none);
    });
  });
}
