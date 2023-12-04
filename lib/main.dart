import 'package:challenge_mobile_developer/core/infra/initializers/infra_initializer.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_route.dart';
import 'package:flutter/material.dart';

void main() async {
  await const InfraInitializer().loadDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: const {
        LoginScreenRoute.path: LoginScreenRoute.of,
      },
      initialRoute: LoginScreenRoute.path,
    );
  }
}
