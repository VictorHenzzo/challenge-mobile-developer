import 'package:challenge_mobile_developer/core/domain/use_cases/delete_student_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../spies.dart';

void main() {
  late DeleteStudentUseCaseImpl sut;
  late StudentsRepositorySpy repository;

  setUp(() {
    repository = StudentsRepositorySpy();
    sut = DeleteStudentUseCaseImpl(repository);
  });

  test('Should be able to call repository with the correct values', () async {
    // arrange
    when(() => repository.delete(any())).thenAnswer(
      (final _) async => const Success(null),
    );

    // act
    await sut.delete('id');

    // assert
    verify(() => repository.delete('id')).called(1);
  });

  test('Should be able to return null on success', () async {
    // arrange
    when(() => repository.delete(any())).thenAnswer(
      (final _) async => const Success(null),
    );

    // act
    final result = await sut.delete('id');

    // assert
    expect(result.hasValue, true);
    expect(result.hasError, false);
  });

  test('Should be able to return a AppError on failure', () async {
    // arrange
    when(() => repository.delete(any())).thenAnswer(
      (final _) async => Failure(AppError.empty()),
    );

    // act
    final result = await sut.delete('id');

    // assert
    expect(result.errorOrNull, isA<AppError>());
  });
}
