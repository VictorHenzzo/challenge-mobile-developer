import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

class InfraInitializer {
  const InfraInitializer();

  Future<void> loadDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await const ServiceLocator().configureDependencies();
  }
}
