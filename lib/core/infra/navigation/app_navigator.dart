import 'package:flutter/material.dart';

class AppNavigator {
  const AppNavigator();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  NavigatorState get _currentState => navigatorKey.currentState!;

  void pop<T>({final T? result}) {
    _currentState.pop(result);
  }

  void popUntil<T>(final String routeToGoBack) {
    _currentState.popUntil(
      (final currentRoute) => currentRoute.settings.name == routeToGoBack,
    );
  }

  Future<T?> pushNamed<T>(
    final String routeName, {
    final Object? arguments,
  }) {
    return _currentState.pushNamed<T?>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveAll<T>(
    final String routeName, {
    final Object? arguments,
  }) {
    return _currentState.pushNamedAndRemoveUntil(
      routeName,
      (final route) => false,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T>({
    required final String newRouteName,
    required final String routeToGoBack,
    final Object? arguments,
  }) {
    return _currentState.pushNamedAndRemoveUntil(
      newRouteName,
      (final currentRoute) => currentRoute.settings.name == routeToGoBack,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementNamed<T>(
    final String routeName, {
    final Object? arguments,
  }) {
    return _currentState.pushReplacementNamed<T, T>(
      routeName,
      arguments: arguments,
    );
  }
}
