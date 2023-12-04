import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:challenge_mobile_developer/modules/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenRoute {
  static const String path = '/home';

  static Widget of(final BuildContext context) {
    final dependenciesPresenter =
        const ServiceLocator().get<HomeDependenciesPresenter>();

    return BlocProvider<HomeDependenciesBloc>(
      create: (final _) => dependenciesPresenter as HomeDependenciesBloc,
      child: HomeScreen(
        dependenciesPresenter: dependenciesPresenter,
      ),
    );
  }
}
