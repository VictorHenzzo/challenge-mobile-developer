import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/erros/http_error.dart';
import 'package:injectable/injectable.dart';

@injectable
final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.httpDataSource);

  final HttpDataSource httpDataSource;

  static const String loginEndpoint = '/login';

  @override
  Future<Either<AppError, UserEntity>> signIn({
    required final String email,
    required final String password,
  }) async {
    try {
      final response = await httpDataSource.request(
        url: loginEndpoint,
        method: HttpMethod.post,
        body: {
          'email': email,
          'password': password,
        },
      );

      final json = jsonDecode(response.body);
      final user = UserModel.fromJson(json);

      return Success(user);
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
