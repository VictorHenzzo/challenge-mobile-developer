import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/data/repositories/students_repository_impl.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
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

  group('delete', () {
    setUp(() {});

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: '', statusCode: 200));

      // act
      await sut.delete('id');

      // assert
      verify(
        () => httpDataSource.request(
          url: '/student/id',
          method: HttpMethod.delete,
        ),
      ).called(1);

      verifyNoMoreInteractions(httpDataSource);
    });

    test('Should be able to return null on Success', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: '', statusCode: 200));

      // act
      final result = await sut.delete('id');

      // assert

      expect(result.hasValue, true);
      expect(result.hasError, false);
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
      final result = await sut.delete('id');

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });

  group('createStudent', () {
    late CreateStudentParams createStudentParams;

    setUp(() {
      createStudentParams = CreateStudentParams(
        name: 'name',
        email: 'email@example.com',
        birthdate: DateTime(1983, 11, 10),
        academicRecord: '1234',
        cpf: '12312312300',
      );

      body =
          '{"createdAt":"2023-12-04T15:56:03.026Z","name":"name","birthdate":"1983-11-10","cpf":"12312312300","email":"email@example.com","academic_record":"1234","id":"8"}';
    });

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 201));

      // act
      await sut.create(createStudentParams);

      // assert
      verify(
        () => httpDataSource.request(
          url: '/student',
          method: HttpMethod.post,
          body: {
            'name': 'name',
            'email': 'email@example.com',
            'birthdate': '1983-11-10',
            'academic_record': '1234',
            'cpf': '12312312300'
          },
        ),
      ).called(1);
    });

    test('Should be able to return a StudentEntity on Success', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 201));

      // act
      final result = await sut.create(createStudentParams);

      // assert
      final expectedStudent = StudentModel(
        academicRecord: '1234',
        name: 'name',
        email: 'email@example.com',
        birthdate: DateTime.parse('1983-11-10'),
        createdAt: DateTime.parse('2023-12-04T15:56:03.026Z'),
        cpf: '12312312300',
        id: '8',
      );

      expect(result.valueOrNull, expectedStudent);
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
      final result = await sut.create(createStudentParams);

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });

  group('editStudent', () {
    late EditStudentParams editStudentParams;

    setUp(() {
      editStudentParams = EditStudentParams(
        name: 'name',
        email: 'email@example.com',
        birthdate: DateTime(1983, 11, 10),
      );

      body =
          '{"createdAt":"2023-12-04T15:56:03.026Z","name":"name","birthdate":"1983-11-10","cpf":"12312312300","email":"email@example.com","academic_record":"1234","id":"8"}';
    });

    test('Should be able to call httpDataSource with the correct values',
        () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 201));

      // act
      await sut.edit(
        id: 'id',
        params: editStudentParams,
      );

      // assert
      verify(
        () => httpDataSource.request(
          url: '/student/id',
          method: HttpMethod.put,
          body: {
            'name': 'name',
            'email': 'email@example.com',
            'birthdate': '1983-11-10'
          },
        ),
      ).called(1);
    });

    test('Should be able to return a StudentEntity on Success', () async {
      // arrange
      mockHttpDataSource(HttpResponse(body: body, statusCode: 201));

      // act
      final result = await sut.edit(
        id: 'id',
        params: editStudentParams,
      );

      // assert
      final expectedStudent = StudentModel(
        academicRecord: '1234',
        name: 'name',
        email: 'email@example.com',
        birthdate: DateTime.parse('1983-11-10'),
        createdAt: DateTime.parse('2023-12-04T15:56:03.026Z'),
        cpf: '12312312300',
        id: '8',
      );

      expect(result.valueOrNull, expectedStudent);
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
      final result = await sut.edit(
        id: 'id',
        params: editStudentParams,
      );

      // assert
      expect(result.errorOrNull, isA<AppError>());
    });
  });
}
