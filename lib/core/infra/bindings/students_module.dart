import 'package:challenge_mobile_developer/core/data/repositories/students_repository_impl.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/delete_student_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/fetch_students_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StudentsModule {
  StudentsRepository studentsRepository(
    final StudentsRepositoryImpl repository,
  ) =>
      repository;

  FetchStudentsUseCase fetchStudentsUseCase(
    final FetchStudentsUseCaseImpl useCase,
  ) =>
      useCase;

  DeleteStudentUseCase deleteStudentUseCase(
    final DeleteStudentUseCaseImpl useCase,
  ) =>
      useCase;
}
