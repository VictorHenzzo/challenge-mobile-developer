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
import 'package:challenge_mobile_developer/core/infra/bindings/http_data_source_module.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final httpDataSourceModule = _$HttpDataSourceModule();
    gh.factory<_i3.Client>(() => httpDataSourceModule.client);
    gh.factory<_i4.HttpDataSource>(() => httpDataSourceModule.httpDataSource());
    gh.factory<_i5.HttpDataSourceAdapter>(
        () => _i5.HttpDataSourceAdapter(gh<_i3.Client>()));
    return this;
  }
}

class _$HttpDataSourceModule extends _i6.HttpDataSourceModule {}
