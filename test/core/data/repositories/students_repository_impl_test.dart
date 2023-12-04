import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/repositories/students_repository_impl.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late StudentsRepositoryImpl sut;
  late HttpDataSourceSpy httpDataSource;

  late String body;

  setUp(() {
    httpDataSource = HttpDataSourceSpy();
    sut = StudentsRepositoryImpl(httpDataSource);

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

  group('fetchStudents', () {
    setUp(() {
      body =
          '[{"createdAt":"2023-11-02T06:52:27.344Z","name":"ThiagoCury","birthdate":"1983-11-10","cpf":"00271700040","email":"thiago@gmail.com","academic_record":"1234","id":"1"},{"createdAt":"2023-11-02T06:52:27.344Z","name":"ThiagoCury","birthdate":"1983-11-10","cpf":"00271700040","email":"thiago@gmail.com","academic_record":"1234","id":"1"}]';
    });

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));

      // act
      await sut.fetchStudents();

      // assert
      verify(
        () => httpDataSource.request(
          url: '/student',
          method: HttpMethod.get,
        ),
      ).called(1);

      verifyNoMoreInteractions(httpDataSource);
    });

    test('Should be able to return a List of Students', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 200));

      // act
      final result = await sut.fetchStudents();

      // assert

      expect(result.valueOrNull, isA<List<StudentEntity>>());
    });

    test('Should be able to return AppError on HttpError', () async {
      // arrange
      when(
        () => httpDataSource.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      ).thenThrow(const ServerError());

      // act
      final result = await sut.fetchStudents();

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });
}
