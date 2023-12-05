part of '../home_screen.dart';

class _StudentsListWidget extends StatelessWidget {
  const _StudentsListWidget({
    required this.state,
  }) : super(key: const Key('studentsListWidget'));

  final HomeDependenciesLoadedState state;

  @override
  Widget build(final BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        ListView.builder(
          itemCount: state.students.length,
          padding: EdgeInsets.only(
            top: screenSize.height * 0.01,
            bottom: screenSize.height * 0.1,
            left: screenSize.width * 0.02,
            right: screenSize.width * 0.02,
          ),
          itemBuilder: (final context, final index) {
            final student = state.students[index];

            return _StudentListTile(
              student: student,
              onDelete: () {},
              onEdit: () {},
            );
          },
        ),
        Positioned(
          bottom: 15,
          left: screenSize.width * 0.20,
          right: screenSize.width * 0.20,
          child: _AddNewStudentButtonWidget(
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
