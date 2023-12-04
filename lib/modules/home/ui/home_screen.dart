import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.dependenciesPresenter,
  }) : super(key: const Key('homeScreen'));

  final HomeDependenciesPresenter dependenciesPresenter;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
      ),
    );
  }
}
