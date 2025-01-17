import 'package:challenge_mobile_developer/core/infra/initializers/infra_initializer.dart';
import 'package:challenge_mobile_developer/core/infra/navigation/app_navigator.dart';
import 'package:challenge_mobile_developer/core/infra/navigation/route_manager.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_route.dart';
import 'package:challenge_mobile_developer/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await const InfraInitializer().loadDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Challenge Mobile Developer',
      debugShowCheckedModeBanner: false,
      theme: const AppThemeData().theme,
      navigatorKey: AppNavigator.navigatorKey,
      initialRoute: LoginScreenRoute.path,
      onGenerateRoute: const RouteManager().onGenerateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    );
  }
}
