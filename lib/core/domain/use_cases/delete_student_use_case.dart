import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteStudentUseCase {
  Future<Either<AppError, void>> delete(final String id);
}

@injectable
class DeleteStudentUseCaseImpl implements DeleteStudentUseCase {
  DeleteStudentUseCaseImpl(this.repository);

  final StudentsRepository repository;

  @override
  Future<Either<AppError, void>> delete(final String id) {
    return repository.delete(id);
  }
}
