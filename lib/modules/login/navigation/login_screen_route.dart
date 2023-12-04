import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart';
import 'package:challenge_mobile_developer/modules/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenRoute {
  static const String path = '/login';

  static Widget of(final BuildContext context) {
    final presenter = const ServiceLocator().get<LoginPresenter>();

    return BlocProvider<LoginBloc>(
      create: (final _) => presenter as LoginBloc,
      child: LoginScreen(presenter: presenter),
    );
  }
}
