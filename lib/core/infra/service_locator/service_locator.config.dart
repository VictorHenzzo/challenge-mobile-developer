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
    as _i8;
import 'package:challenge_mobile_developer/core/data/repositories/user_repository_impl.dart'
    as _i10;
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart'
    as _i11;
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart'
    as _i12;
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart'
    as _i13;
import 'package:challenge_mobile_developer/core/infra/bindings/http_data_source_module.dart'
    as _i16;
import 'package:challenge_mobile_developer/core/infra/bindings/local_data_source_module.dart'
    as _i17;
import 'package:challenge_mobile_developer/core/infra/bindings/user_module.dart'
    as _i18;
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_directions.dart'
    as _i6;
import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart'
    as _i15;
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart'
    as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

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
    gh.factory<_i6.LoginScreenDirections>(() => _i6.LoginScreenDirections());
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => localDataSourceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i8.SharedPreferencesLocalDataSource>(() =>
        _i8.SharedPreferencesLocalDataSource(
            sharedPreferences: gh<_i7.SharedPreferences>()));
    gh.factory<_i9.LocalDataSource>(() => localDataSourceModule
        .localDataSource(gh<_i8.SharedPreferencesLocalDataSource>()));
    gh.factory<_i10.UserRepositoryImpl>(() => _i10.UserRepositoryImpl(
          gh<_i4.HttpDataSource>(),
          gh<_i9.LocalDataSource>(),
        ));
    gh.factory<_i11.UserRepository>(
        () => authModule.authRepository(gh<_i10.UserRepositoryImpl>()));
    gh.factory<_i12.CheckAuthStateUseCaseImpl>(
        () => _i12.CheckAuthStateUseCaseImpl(gh<_i11.UserRepository>()));
    gh.factory<_i13.SignInUseCaseImpl>(
        () => _i13.SignInUseCaseImpl(gh<_i11.UserRepository>()));
    gh.factory<_i12.CheckAuthStateUseCase>(() =>
        authModule.checkAuthStateUseCase(gh<_i12.CheckAuthStateUseCaseImpl>()));
    gh.factory<_i13.SignInUseCase>(
        () => authModule.signInUseCase(gh<_i13.SignInUseCaseImpl>()));
    gh.factory<_i14.LoginPresenter>(() => _i15.LoginBloc(
          checkAuthStateUseCase: gh<_i12.CheckAuthStateUseCase>(),
          signInUseCase: gh<_i13.SignInUseCase>(),
          directions: gh<_i6.LoginScreenDirections>(),
        ));
    return this;
  }
}

class _$HttpDataSourceModule extends _i16.HttpDataSourceModule {}

class _$LocalDataSourceModule extends _i17.LocalDataSourceModule {}

class _$AuthModule extends _i18.AuthModule {}
