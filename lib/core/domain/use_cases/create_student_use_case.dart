import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:injectable/injectable.dart';

abstract class CreateStudentUseCase {
  Future<Either<AppError, StudentEntity>> create(
    final CreateStudentParams params,
  );
}

@injectable
class CreateStudentUseCaseImpl implements CreateStudentUseCase {
  CreateStudentUseCaseImpl(this.repository);

  final StudentsRepository repository;

  @override
  Future<Either<AppError, StudentEntity>> create(
    final CreateStudentParams params,
  ) {
    return repository.create(params);
  }
}
