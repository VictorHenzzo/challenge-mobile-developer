import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/data/repositories/auth_repository_impl.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/erros/http_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late AuthRepositoryImpl sut;
  late HttpDataSourceSpy httpDataSource;

  setUp(() {
    httpDataSource = HttpDataSourceSpy();
    sut = AuthRepositoryImpl(httpDataSource);

    registerFallbackValue(HttpMethod.get);
  });

  group('SignIn', () {
    late String email;
    late String password;
    late String body;

    setUp(() {
      email = 'mail@mail.example';
      password = 'password';

      body =
          '{"createdAt":"2023-11-02T18:54:47.981Z","email":"joao@gmail.com","token":"cb15fbdff6ad7fe1604fee7d","password":"123456","id":"1"}';
    });

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      when(
        () => httpDataSource.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (final _) async => HttpResponse(body: body, statusCode: 200),
      );

      // act
      await sut.signIn(email: email, password: password);

      // assert
      verify(
        () => httpDataSource.request(
          url: '/login',
          method: HttpMethod.post,
          body: {
            'email': email,
            'password': password,
          },
        ),
      ).called(1);

      verifyNoMoreInteractions(httpDataSource);
    });

    test('Should be able to return a UserEntity on Success', () async {
      // arrange
      when(
        () => httpDataSource.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (final _) async => HttpResponse(body: body, statusCode: 200),
      );

      // act
      final result = await sut.signIn(email: email, password: password);

      // assert
      final expectedUser = UserModel(
        createdAt: DateTime.parse('2023-11-02T18:54:47.981Z'),
        email: 'joao@gmail.com',
        token: 'cb15fbdff6ad7fe1604fee7d',
        password: '123456',
        id: '1',
      );

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
      final result = await sut.signIn(email: email, password: password);

      // assert

      expect(result.errorOrNull, isA<AppError>());
    });
  });
}
