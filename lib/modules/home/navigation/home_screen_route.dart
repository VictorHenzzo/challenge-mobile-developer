import 'package:challenge_mobile_developer/modules/home/ui/home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenRoute {
  static const String path = '/home';

  static Widget of(final BuildContext context) {
    return const HomeScreen();
  }
}
