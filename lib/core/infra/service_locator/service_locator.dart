import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.config.dart';

@InjectableInit()
class ServiceLocator {
  const ServiceLocator();

  GetIt get _getIt => GetIt.instance;

  Future<void> configureDependencies() => _getIt.init();

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
