import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:challenge_mobile_developer/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/home_screen_error_widget.dart';
part 'components/students_list_widget.dart';
part 'components/student_list_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    required this.dependenciesPresenter,
  }) : super(key: const Key('homeScreen')) {
    _fetchContent();
  }

  final HomeDependenciesPresenter dependenciesPresenter;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<HomeDependenciesBloc, HomeDependenciesState>(
          builder: (final _, final state) {
            return switch (state) {
              (final HomeDependenciesLoadedState loadedState) =>
                _StudentsListWidget(
                  state: loadedState,
                ),
              (final HomeDependenciesErrorState _) => _HomeScreenErrorWidget(
                  tryAgain: _fetchContent,
                ),
              _ => const CustomLoadingWidget(),
            };
          },
        ),
      ),
    );
  }

  void _fetchContent() {
    dependenciesPresenter.addEvent(
      const HomeDependenciesFetchEvent(),
    );
  }
}
