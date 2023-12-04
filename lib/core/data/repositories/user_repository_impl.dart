import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart';
import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';
import 'package:challenge_mobile_developer/core/infra/erros/http_error.dart';
import 'package:injectable/injectable.dart';

@injectable
final class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.httpDataSource, this.localDataSource);

  final HttpDataSource httpDataSource;
  final LocalDataSource localDataSource;

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

      final user = _userFromEncodedString(response.body);

      final result = await localDataSource.save(
        key: UserModel.cacheKey,
        value: response.body,
      );

      if (result.hasError) {
        return Failure(result.errorOrNull!);
      }

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

  @override
  Future<Either<AppError, UserEntity>> getUserById(
    final String id,
  ) async {
    try {
      final response = await httpDataSource.request(
        url: '$loginEndpoint/$id',
        method: HttpMethod.get,
      );

      final user = _userFromEncodedString(response.body);

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

  @override
  Future<Either<AppError, UserEntity?>> getUserFromLocal() {
    // TODO: implement getUserFromLocal
    throw UnimplementedError();
  }

  UserEntity _userFromEncodedString(final String body) {
    final json = jsonDecode(body);
    return UserModel.fromJson(json);
  }
}
