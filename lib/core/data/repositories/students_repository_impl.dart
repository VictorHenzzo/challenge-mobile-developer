import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';
import 'package:injectable/injectable.dart';

@injectable
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

  @override
  Future<Either<AppError, void>> delete(final String id) async {
    try {
      await httpDataSource.request(
        url: '$studentEndpoint/$id',
        method: HttpMethod.delete,
      );

      return const Success(null);
    } on HttpError catch (exception, stackTrace) {
      return Failure(
        AppError(
          stackTrace: stackTrace,
          message: exception.message,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, StudentEntity>> create(
    final CreateStudentParams params,
  ) async {
    try {
      final result = await httpDataSource.request(
        url: studentEndpoint,
        method: HttpMethod.post,
        body: params.toJson(),
      );

      final json = jsonDecode(result.body);
      final student = StudentModel.fromJson(json);

      return Success(student);
    } on HttpError catch (exception, stackTrace) {
      return Failure(
        AppError(
          stackTrace: stackTrace,
          message: exception.message,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, StudentEntity>> edit({
    required final String id,
    required final EditStudentParams params,
  }) async {
    try {
      final result = await httpDataSource.request(
        url: '$studentEndpoint/$id',
        method: HttpMethod.put,
        body: params.toJson(),
      );

      final json = jsonDecode(result.body);
      final student = StudentModel.fromJson(json);

      return Success(student);
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
