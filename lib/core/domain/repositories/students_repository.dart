import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';

abstract class StudentsRepository {
  Future<Either<AppError, List<StudentEntity>>> fetchStudents();

  Future<Either<AppError, void>> delete(final String id);

  Future<Either<AppError, StudentEntity>> create(
    final CreateStudentParams params,
  );

  Future<Either<AppError, StudentEntity>> edit({
    required final String id,
    required final EditStudentParams params,
  });
}
