import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:injectable/injectable.dart';

abstract class FetchStudentsUseCase {
  Future<Either<AppError, List<StudentEntity>>> fetchStudents();
}

@injectable
class FetchStudentsUseCaseImpl implements FetchStudentsUseCase {
  FetchStudentsUseCaseImpl(this.repository);

  final StudentsRepository repository;

  @override
  Future<Either<AppError, List<StudentEntity>>> fetchStudents() {
    return repository.fetchStudents();
  }
}
