import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

@InjectableInit()
class ServiceLocator {
  const ServiceLocator();

  GetIt get _getIt => GetIt.instance;

  void configureDependencies() => _getIt.init();

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
