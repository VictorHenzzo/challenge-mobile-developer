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
    as _i8;
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/shared_preferences_local_data_source.dart'
    as _i7;
import 'package:challenge_mobile_developer/core/data/repositories/user_repository_impl.dart'
    as _i9;
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart'
    as _i10;
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart'
    as _i11;
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart'
    as _i12;
import 'package:challenge_mobile_developer/core/infra/bindings/http_data_source_module.dart'
    as _i13;
import 'package:challenge_mobile_developer/core/infra/bindings/local_data_source_module.dart'
    as _i14;
import 'package:challenge_mobile_developer/core/infra/bindings/user_module.dart'
    as _i15;
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
    gh.factory<_i8.LocalDataSource>(() => localDataSourceModule
        .localDataSource(gh<_i7.SharedPreferencesLocalDataSource>()));
    gh.factory<_i9.UserRepositoryImpl>(() => _i9.UserRepositoryImpl(
          gh<_i4.HttpDataSource>(),
          gh<_i8.LocalDataSource>(),
        ));
    gh.factory<_i10.UserRepository>(
        () => authModule.authRepository(gh<_i9.UserRepositoryImpl>()));
    gh.factory<_i11.CheckAuthStateUseCaseImpl>(
        () => _i11.CheckAuthStateUseCaseImpl(gh<_i10.UserRepository>()));
    gh.factory<_i12.SignInUseCaseImpl>(
        () => _i12.SignInUseCaseImpl(gh<_i10.UserRepository>()));
    gh.factory<_i11.CheckAuthStateUseCase>(() =>
        authModule.checkAuthStateUseCase(gh<_i11.CheckAuthStateUseCaseImpl>()));
    gh.factory<_i12.SignInUseCase>(
        () => authModule.signInUseCase(gh<_i12.SignInUseCaseImpl>()));
    return this;
  }
}

class _$HttpDataSourceModule extends _i13.HttpDataSourceModule {}

class _$LocalDataSourceModule extends _i14.LocalDataSourceModule {}

class _$AuthModule extends _i15.AuthModule {}
