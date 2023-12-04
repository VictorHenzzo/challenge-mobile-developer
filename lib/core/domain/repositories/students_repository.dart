import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';

abstract class StudentsRepository {
  Future<Either<AppError, List<StudentEntity>>> fetchStudents();
}
