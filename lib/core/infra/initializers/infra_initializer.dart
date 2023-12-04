import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';

class InfraInitializer {
  const InfraInitializer();

  Future<void> loadDependencies() async {
    const ServiceLocator().configureDependencies();
  }
}
