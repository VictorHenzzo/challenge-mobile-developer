// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart'
    as _i4;
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source_adapter.dart'
    as _i5;
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart'
    as _i9;
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/shared_preferences_local_data_source.dart'
    as _i7;
import 'package:challenge_mobile_developer/core/data/repositories/auth_repository_impl.dart'
    as _i8;
import 'package:challenge_mobile_developer/core/domain/repositories/auth_repository.dart'
    as _i10;
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart'
    as _i11;
import 'package:challenge_mobile_developer/core/infra/bindings/auth_module.dart'
    as _i14;
import 'package:challenge_mobile_developer/core/infra/bindings/http_data_source_module.dart'
    as _i12;
import 'package:challenge_mobile_developer/core/infra/bindings/local_data_source_module.dart'
    as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final httpDataSourceModule = _$HttpDataSourceModule();
    final localDataSourceModule = _$LocalDataSourceModule();
    final authModule = _$AuthModule();
    gh.factory<_i3.Client>(() => httpDataSourceModule.client);
    gh.factory<_i4.HttpDataSource>(() => httpDataSourceModule.httpDataSource());
    gh.factory<_i5.HttpDataSourceAdapter>(
        () => _i5.HttpDataSourceAdapter(gh<_i3.Client>()));
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => localDataSourceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i7.SharedPreferencesLocalDataSource>(() =>
        _i7.SharedPreferencesLocalDataSource(
            sharedPreferences: gh<_i6.SharedPreferences>()));
    gh.factory<_i8.AuthRepositoryImpl>(
        () => _i8.AuthRepositoryImpl(gh<_i4.HttpDataSource>()));
    gh.factory<_i9.LocalDataSource>(() => localDataSourceModule
        .localDataSource(gh<_i7.SharedPreferencesLocalDataSource>()));
    gh.factory<_i10.AuthRepository>(
        () => authModule.authRepository(gh<_i8.AuthRepositoryImpl>()));
    gh.factory<_i11.SignInUseCaseImpl>(
        () => _i11.SignInUseCaseImpl(gh<_i10.AuthRepository>()));
    gh.factory<_i11.SignInUseCase>(
        () => authModule.signInUseCase(gh<_i11.SignInUseCaseImpl>()));
    return this;
  }
}

class _$HttpDataSourceModule extends _i12.HttpDataSourceModule {}

class _$LocalDataSourceModule extends _i13.LocalDataSourceModule {}

class _$AuthModule extends _i14.AuthModule {}
