import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_bloc/students_manager_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_presenter.dart';
import 'package:challenge_mobile_developer/modules/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenRoute {
  static const String path = '/home';

  static Widget of(final BuildContext context) {
    final dependenciesPresenter =
        const ServiceLocator().get<HomeDependenciesPresenter>();

    final studentsManagerPresenter =
        const ServiceLocator().get<StudentsManagerPresenter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (final _) => dependenciesPresenter as HomeDependenciesBloc,
        ),
        BlocProvider(
          create: (final _) => studentsManagerPresenter as StudentsManagerBloc,
        ),
      ],
      child: HomeScreen(
        dependenciesPresenter: dependenciesPresenter,
        studentsManagerPresenter: studentsManagerPresenter,
      ),
    );
  }
}
