import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.presenter,
  }) : super(key: const Key('loginScreen'));

  final LoginPresenter presenter;

  @override
  Widget build(final BuildContext context) {
    return const Scaffold();
  }
}
