import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/data/repositories/user_repository_impl.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late UserRepositoryImpl sut;
  late HttpDataSourceSpy httpDataSource;
  late LocalDataSourceSpy localDataSource;

  late String body;
  late UserModel expectedUser;

  setUp(() {
    httpDataSource = HttpDataSourceSpy();
    localDataSource = LocalDataSourceSpy();
    sut = UserRepositoryImpl(httpDataSource, localDataSource);

    body =
        '{"createdAt":"2023-11-02T18:54:47.981Z","email":"joao@gmail.com","token":"cb15fbdff6ad7fe1604fee7d","password":"123456","id":"1"}';

    expectedUser = UserModel.fromJson(jsonDecode(body));

    registerFallbackValue(HttpMethod.get);
  });

  void mockHttpDataSource(final HttpResponse response) {
    when(
      () => httpDataSource.request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (final _) async => response,
    );
  }

  void mockLocalDataSourceSave(
    final Either<AppError, void> result,
  ) {
    when(
      () => localDataSource.save(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer(
      (final _) async => result,
    );
  }

  group('SignIn', () {
    late String email;
    late String password;

    setUp(() {
      email = 'mail@mail.example';
      password = 'password';
    });

    test(
        'Should be able to call httpDataSource and then local data source with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));
      mockLocalDataSourceSave(const Success(null));

      // act
      await sut.signIn(email: email, password: password);

      // assert
      verifyInOrder(
        [
          () => httpDataSource.request(
                url: '/login',
                method: HttpMethod.post,
                body: {
                  'email': email,
                  'password': password,
                },
              ),
          () => localDataSource.save(
                key: UserModel.cacheKey,
                value: body,
              ),
        ],
      );

      verifyNoMoreInteractions(httpDataSource);
      verifyNoMoreInteractions(localDataSource);
    });

    test('Should be able to return a UserEntity on Success', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));
      mockLocalDataSourceSave(const Success(null));

      // act
      final result = await sut.signIn(email: email, password: password);

      // assert

      expect(result.valueOrNull, expectedUser);
    });

    test(
        'Should be able to return a AppError on httpError, without calling localDataSource',
        () async {
      // arrange
      when(
        () => httpDataSource.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      ).thenThrow(const ServerError());

      // act
      final result = await sut.signIn(email: email, password: password);

      // assert
      expect(result.errorOrNull, isA<AppError>());

      verifyNoMoreInteractions(localDataSource);
    });

    test('Should be able to return a AppError if localDataSource returns error',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));
      mockLocalDataSourceSave(Failure(AppError.empty()));

      // act
      final result = await sut.signIn(email: email, password: password);

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });

  group('getUserById', () {
    late String userId;

    setUp(() {
      userId = 'userId';
    });

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));

      // act
      await sut.getUserById(userId);

      // assert
      verify(
        () => httpDataSource.request(
          url: '/login/$userId',
          method: HttpMethod.get,
        ),
      ).called(1);

      verifyNoMoreInteractions(httpDataSource);
    });

    test('Should be able to return a UserEntity on Success', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));

      // act
      final result = await sut.getUserById(userId);

      // assert

      expect(result.valueOrNull, expectedUser);
    });

    test('Should be able to return a AppError on httpError', () async {
      // arrange
      when(
        () => httpDataSource.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      ).thenThrow(const ServerError());

      // act
      final result = await sut.getUserById(userId);

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });

  group('getUserFromLocal', () {
    void mockLocalDataSourceFetch(
      final Either<AppError, String?> result,
    ) {
      when(
        () => localDataSource.fetch(
          key: any(named: 'key'),
        ),
      ).thenAnswer(
        (final _) async => result,
      );
    }

    test('Should be able to call localDataSource with the correct values',
        () async {
      // arrange
      mockLocalDataSourceFetch(Success(body));

      // act
      await sut.getUserFromLocal();

      // assert
      verify(
        () => localDataSource.fetch(
          key: UserModel.cacheKey,
        ),
      ).called(1);
    });

    test('Should be able to return a UserEntity on Success', () async {
      // arrange
      mockLocalDataSourceFetch(Success(body));

      // act
      final result = await sut.getUserFromLocal();

      // assert
      expect(result.valueOrNull, expectedUser);
    });

    test('Should be able to return null if localDataSource returns null',
        () async {
      // arrange
      mockLocalDataSourceFetch(const Success(null));

      // act
      final result = await sut.getUserFromLocal();

      // assert
      expect(result.valueOrNull, null);
      expect(result.errorOrNull, null);
    });

    test(
        'Should be able to return a AppError if localDataSource returns AppError',
        () async {
      // arrange
      mockLocalDataSourceFetch(Failure(AppError.empty()));

      // act
      final result = await sut.getUserFromLocal();

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });
}
