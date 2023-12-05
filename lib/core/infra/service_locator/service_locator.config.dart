// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart'
    as _i6;
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source_adapter.dart'
    as _i7;
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart'
    as _i12;
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/shared_preferences_local_data_source.dart'
    as _i10;
import 'package:challenge_mobile_developer/core/data/repositories/students_repository_impl.dart'
    as _i11;
import 'package:challenge_mobile_developer/core/data/repositories/user_repository_impl.dart'
    as _i14;
import 'package:challenge_mobile_developer/core/domain/repositories/students_repository.dart'
    as _i13;
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart'
    as _i19;
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart'
    as _i20;
import 'package:challenge_mobile_developer/core/domain/use_cases/create_student_use_case.dart'
    as _i15;
import 'package:challenge_mobile_developer/core/domain/use_cases/delete_student_use_case.dart'
    as _i16;
import 'package:challenge_mobile_developer/core/domain/use_cases/edit_student_use_case.dart'
    as _i17;
import 'package:challenge_mobile_developer/core/domain/use_cases/fetch_students_use_case.dart'
    as _i18;
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart'
    as _i23;
import 'package:challenge_mobile_developer/core/infra/bindings/http_data_source_module.dart'
    as _i30;
import 'package:challenge_mobile_developer/core/infra/bindings/local_data_source_module.dart'
    as _i31;
import 'package:challenge_mobile_developer/core/infra/bindings/students_module.dart'
    as _i32;
import 'package:challenge_mobile_developer/core/infra/bindings/user_module.dart'
    as _i33;
import 'package:challenge_mobile_developer/modules/edit_student/navigation/student_edit_directions.dart'
    as _i4;
import 'package:challenge_mobile_developer/modules/edit_student/presentation/bloc/edit_student_bloc.dart'
    as _i27;
import 'package:challenge_mobile_developer/modules/edit_student/presentation/edit_student_presenter.dart'
    as _i26;
import 'package:challenge_mobile_developer/modules/home/navigation/home_screen_directions.dart'
    as _i5;
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart'
    as _i22;
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart'
    as _i21;
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_bloc/students_manager_bloc.dart'
    as _i25;
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_presenter.dart'
    as _i24;
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_directions.dart'
    as _i8;
import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart'
    as _i29;
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart'
    as _i28;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

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
    final studentsModule = _$StudentsModule();
    final authModule = _$AuthModule();
    gh.factory<_i3.Client>(() => httpDataSourceModule.client);
    gh.factory<_i4.EditStudentScreenDirections>(
        () => _i4.EditStudentScreenDirections());
    gh.factory<_i5.HomeScreenDirections>(() => _i5.HomeScreenDirections());
    gh.factory<_i6.HttpDataSource>(() => httpDataSourceModule.httpDataSource());
    gh.factory<_i7.HttpDataSourceAdapter>(
        () => _i7.HttpDataSourceAdapter(gh<_i3.Client>()));
    gh.factory<_i8.LoginScreenDirections>(() => _i8.LoginScreenDirections());
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => localDataSourceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i10.SharedPreferencesLocalDataSource>(() =>
        _i10.SharedPreferencesLocalDataSource(
            sharedPreferences: gh<_i9.SharedPreferences>()));
    gh.factory<_i11.StudentsRepositoryImpl>(
        () => _i11.StudentsRepositoryImpl(gh<_i6.HttpDataSource>()));
    gh.factory<_i12.LocalDataSource>(() => localDataSourceModule
        .localDataSource(gh<_i10.SharedPreferencesLocalDataSource>()));
    gh.factory<_i13.StudentsRepository>(() =>
        studentsModule.studentsRepository(gh<_i11.StudentsRepositoryImpl>()));
    gh.factory<_i14.UserRepositoryImpl>(() => _i14.UserRepositoryImpl(
          gh<_i6.HttpDataSource>(),
          gh<_i12.LocalDataSource>(),
        ));
    gh.factory<_i15.CreateStudentUseCaseImpl>(
        () => _i15.CreateStudentUseCaseImpl(gh<_i13.StudentsRepository>()));
    gh.factory<_i16.DeleteStudentUseCaseImpl>(
        () => _i16.DeleteStudentUseCaseImpl(gh<_i13.StudentsRepository>()));
    gh.factory<_i17.EditStudentUseCaseImpl>(
        () => _i17.EditStudentUseCaseImpl(gh<_i13.StudentsRepository>()));
    gh.factory<_i18.FetchStudentsUseCaseImpl>(
        () => _i18.FetchStudentsUseCaseImpl(gh<_i13.StudentsRepository>()));
    gh.factory<_i19.UserRepository>(
        () => authModule.authRepository(gh<_i14.UserRepositoryImpl>()));
    gh.factory<_i20.CheckAuthStateUseCaseImpl>(
        () => _i20.CheckAuthStateUseCaseImpl(gh<_i19.UserRepository>()));
    gh.factory<_i15.CreateStudentUseCase>(() => studentsModule
        .createStudentUseCase(gh<_i15.CreateStudentUseCaseImpl>()));
    gh.factory<_i16.DeleteStudentUseCase>(() => studentsModule
        .deleteStudentUseCase(gh<_i16.DeleteStudentUseCaseImpl>()));
    gh.factory<_i17.EditStudentUseCase>(() =>
        studentsModule.editStudentUseCase(gh<_i17.EditStudentUseCaseImpl>()));
    gh.factory<_i18.FetchStudentsUseCase>(() => studentsModule
        .fetchStudentsUseCase(gh<_i18.FetchStudentsUseCaseImpl>()));
    gh.factory<_i21.HomeDependenciesPresenter>(() => _i22.HomeDependenciesBloc(
        fetchStudentsUseCase: gh<_i18.FetchStudentsUseCase>()));
    gh.factory<_i23.SignInUseCaseImpl>(
        () => _i23.SignInUseCaseImpl(gh<_i19.UserRepository>()));
    gh.factory<_i24.StudentsManagerPresenter>(() => _i25.StudentsManagerBloc(
          deleteStudentUseCase: gh<_i16.DeleteStudentUseCase>(),
          directions: gh<_i5.HomeScreenDirections>(),
        ));
    gh.factory<_i20.CheckAuthStateUseCase>(() =>
        authModule.checkAuthStateUseCase(gh<_i20.CheckAuthStateUseCaseImpl>()));
    gh.factory<_i26.EditStudentPresenter>(() => _i27.EditStudentBloc(
          directions: gh<_i4.EditStudentScreenDirections>(),
          createStudentUseCase: gh<_i15.CreateStudentUseCase>(),
          editStudentUseCase: gh<_i17.EditStudentUseCase>(),
        ));
    gh.factory<_i23.SignInUseCase>(
        () => authModule.signInUseCase(gh<_i23.SignInUseCaseImpl>()));
    gh.factory<_i28.LoginPresenter>(() => _i29.LoginBloc(
          checkAuthStateUseCase: gh<_i20.CheckAuthStateUseCase>(),
          signInUseCase: gh<_i23.SignInUseCase>(),
          directions: gh<_i8.LoginScreenDirections>(),
        ));
    return this;
  }
}

class _$HttpDataSourceModule extends _i30.HttpDataSourceModule {}

class _$LocalDataSourceModule extends _i31.LocalDataSourceModule {}

class _$StudentsModule extends _i32.StudentsModule {}

class _$AuthModule extends _i33.AuthModule {}
