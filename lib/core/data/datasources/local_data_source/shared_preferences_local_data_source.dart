import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/erros/app_error.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart';

@injectable
final class SharedPreferencesLocalDataSource implements LocalDataSource {
  const SharedPreferencesLocalDataSource({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<Either<AppError, void>> save({
    required final String key,
    required final String value,
  }) async {
    try {
      await sharedPreferences.setString(key, value);

      return const Success(null);
    } catch (exception, stackTrace) {
      return Failure(
        AppError(
          message:
              "Failed to save '$key' key with $value value. Error: $exception",
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, String?>> fetch({
    required final String key,
  }) async {
    try {
      return Success(
        sharedPreferences.getString(key),
      );
    } catch (exception, stackTrace) {
      return Failure(
        AppError(
          message: "Failed to fetch '$key' key. Error: $exception",
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, bool>> delete({
    required final String key,
  }) async {
    try {
      final result = await sharedPreferences.remove(key);
      return Success(result);
    } catch (exception, stackTrace) {
      return Failure(
        AppError(
          message: "Failed to delete '$key' key. Error: $exception",
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, void>> deleteAll() async {
    try {
      await sharedPreferences.clear();

      return const Success(null);
    } catch (exception, stackTrace) {
      return Failure(
        AppError(
          message: 'Failed to clear all cache',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
