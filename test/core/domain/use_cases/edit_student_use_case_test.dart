import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/edit_student_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late EditStudentUseCaseImpl sut;
  late StudentsRepositorySpy repository;

  late EditStudentParams params;
  late StudentEntity student;

  setUp(() {
    repository = StudentsRepositorySpy();
    sut = EditStudentUseCaseImpl(repository);

    params = EditStudentParams(
      name: 'name',
      email: 'email@example.com',
      birthdate: DateTime(1983, 11, 10),
    );

    student = StudentModel.empty();

    registerFallbackValue(params);
  });

  test('Should be able to call repository with the correct values', () async {
    // arrange
    when(
      () => repository.edit(
        id: any(named: 'id'),
        params: any(named: 'params'),
      ),
    ).thenAnswer((final _) async => Success(student));

    // act
    await sut.edit(id: 'id', params: params);

    // assert
    verify(() => repository.edit(id: 'id', params: params)).called(1);
  });

  test('Should be able to return a student on success', () async {
    // arrange
    when(
      () => repository.edit(
        id: any(named: 'id'),
        params: any(named: 'params'),
      ),
    ).thenAnswer((final _) async => Success(student));

    // act
    final result = await sut.edit(id: 'id', params: params);

    // assert
    expect(result.valueOrNull, student);
  });

  test('Should be able to return a AppError on failure', () async {
    // arrange
    when(
      () => repository.edit(
        id: any(named: 'id'),
        params: any(named: 'params'),
      ),
    ).thenAnswer((final _) async => Failure(AppError.empty()));

    // act
    final result = await sut.edit(id: 'id', params: params);

    // assert
    expect(result.errorOrNull, isA<AppError>());
  });
}
