import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';

abstract class LocalDataSource {
  const LocalDataSource();

  Future<Either<AppError, void>> save({
    required final String key,
    required final String value,
  });

  Future<Either<AppError, String?>> fetch({
    required final String key,
  });

  Future<Either<AppError, bool>> delete({
    required final String key,
  });

  Future<Either<AppError, void>> deleteAll();
}
