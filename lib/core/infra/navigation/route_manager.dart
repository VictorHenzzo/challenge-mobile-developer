import 'package:challenge_mobile_developer/modules/home/navigation/home_screen_route.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_route.dart';
import 'package:flutter/material.dart';

class RouteManager {
  const RouteManager();

  Route<dynamic>? onGenerateRoute(final RouteSettings routeSettings) {
    final routeName = routeSettings.name;

    return switch (routeName) {
      HomeScreenRoute.path => HomeScreenRoute.of(),
      _ => LoginScreenRoute.of(),
    };
  }
}
