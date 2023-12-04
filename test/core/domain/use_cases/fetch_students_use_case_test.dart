import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/fetch_students_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late FetchStudentsUseCaseImpl sut;
  late StudentsRepositorySpy repository;

  late List<StudentEntity> students;

  setUp(() {
    repository = StudentsRepositorySpy();
    sut = FetchStudentsUseCaseImpl(repository);

    students = [StudentModel.empty()];
  });

  test('Should be able to call repository with the correct values', () async {
    // arrange
    when(repository.fetchStudents).thenAnswer(
      (final _) async => Success(students),
    );

    // act
    await sut.fetchStudents();

    // assert
    verify(repository.fetchStudents).called(1);
  });

  test('Should be able to return a List of StudentEntity on success', () async {
    // arrange
    when(repository.fetchStudents).thenAnswer(
      (final _) async => Success(students),
    );

    // act
    final result = await sut.fetchStudents();

    // assert
    expect(result.valueOrNull, students);
  });

  test('Should be able to return a AppError on failure', () async {
    // arrange
    when(repository.fetchStudents).thenAnswer(
      (final _) async => Failure(AppError.empty()),
    );

    // act
    final result = await sut.fetchStudents();

    // assert
    expect(result.errorOrNull, isA<AppError>());
  });
}
