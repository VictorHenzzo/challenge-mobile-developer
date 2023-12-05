import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_bloc/students_manager_bloc.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_presenter.dart';
import 'package:challenge_mobile_developer/widgets/app_bottom_nav_bar.dart';
import 'package:challenge_mobile_developer/widgets/custom_loading_widget.dart';
import 'package:challenge_mobile_developer/widgets/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/home_screen_error_widget.dart';
part 'components/students_list_widget.dart';
part 'components/student_list_tile.dart';
part 'components/add_new_student_button_widget.dart';
part 'components/alert_dialogs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    required this.dependenciesPresenter,
    required this.studentsManagerPresenter,
  }) : super(key: const Key('homeScreen')) {
    _fetchContent();
  }

  final HomeDependenciesPresenter dependenciesPresenter;
  final StudentsManagerPresenter studentsManagerPresenter;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
      ),
      bottomNavigationBar: const AppBottomNavBar(),
      body: BlocBuilder<HomeDependenciesBloc, HomeDependenciesState>(
        builder: (final _, final state) {
          return switch (state) {
            (final HomeDependenciesLoadedState loadedState) =>
              _StudentsListWidget(
                students: loadedState.students,
                onDeleteTap: _showDeleteDialog,
              ),
            (final HomeDependenciesErrorState _) => _HomeScreenErrorWidget(
                tryAgain: _fetchContent,
              ),
            _ => const CustomLoadingWidget(),
          };
        },
      ),
    );
  }

  void _fetchContent() {
    dependenciesPresenter.addEvent(
      const HomeDependenciesFetchEvent(),
    );
  }

  void _showDeleteDialog({
    required final BuildContext context,
    required final StudentEntity student,
  }) {
    showDialog(
      context: context,
      builder: (final _) {
        return _ConfirmStudentDeletionAlertDialog(
          dismiss: _dismiss,
          onConfirm: _deleteStudent,
          student: student,
        );
      },
    );
  }

  void _deleteStudent(final StudentEntity student) {
    studentsManagerPresenter.addEvent(
      StudentsManagerDeleteEvent(student),
    );
  }

  void _dismiss() {
    studentsManagerPresenter.addEvent(
      const StudentsManagerDismissEvent(),
    );
  }
}
