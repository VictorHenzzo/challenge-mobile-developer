import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:injectable/injectable.dart';

abstract class EditStudentUseCase {
  Future<Either<AppError, StudentEntity>> edit({
    required final String id,
    required final EditStudentParams params,
  });
}

@injectable
class EditStudentUseCaseImpl implements EditStudentUseCase {
  EditStudentUseCaseImpl(this.repository);

  final StudentsRepository repository;

  @override
  Future<Either<AppError, StudentEntity>> edit({
    required final String id,
    required final EditStudentParams params,
  }) {
    return repository.edit(id: id, params: params);
  }
}
