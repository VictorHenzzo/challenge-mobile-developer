part of '../home_screen.dart';

class _StudentsListWidget extends StatelessWidget {
  const _StudentsListWidget({
    required this.state,
  }) : super(key: const Key('studentsListWidget'));

  final HomeDependenciesLoadedState state;

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      itemCount: state.students.length,
      itemBuilder: (final context, final index) {
        final student = state.students[index];

        return _StudentListTile(
          student: student,
          onDelete: () {},
          onEdit: () {},
        );
      },
    );
  }
}
