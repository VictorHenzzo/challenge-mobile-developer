import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  StudentsRepositoryImpl(this.httpDataSource);

  final HttpDataSource httpDataSource;

  static const String studentEndpoint = '/student';

  @override
  Future<Either<AppError, List<StudentEntity>>> fetchStudents() async {
    try {
      final result = await httpDataSource.request(
        url: studentEndpoint,
        method: HttpMethod.get,
      );

      final json = jsonDecode(result.body) as List<dynamic>;

      final students = json
          // ignore: unnecessary_lambdas
          .map((final item) => StudentModel.fromJson(item))
          .toList(growable: false);

      return Success(students);
    } on HttpError catch (exception, stackTrace) {
      return Failure(
        AppError(
          stackTrace: stackTrace,
          message: exception.message,
        ),
      );
    }
  }
}
