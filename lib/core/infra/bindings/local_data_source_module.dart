import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart';
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/shared_preferences_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalDataSourceModule {
  @preResolve
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();

  LocalDataSource localDataSource(
    final SharedPreferencesLocalDataSource sharedPreferencesLocalDataSource,
  ) =>
      sharedPreferencesLocalDataSource;
}
