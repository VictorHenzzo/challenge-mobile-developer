part of '../home_screen.dart';

class _StudentsListWidget extends StatelessWidget {
  _StudentsListWidget({
    required final List<StudentEntity> students,
    required this.deleteStudent,
  })  : students = List.from(students),
        super(key: const Key('studentsListWidget'));

  final List<StudentEntity> students;
  final void Function(StudentEntity) deleteStudent;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  AnimatedListState? get _animatedList => _listKey.currentState;

  @override
  Widget build(final BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<StudentsManagerBloc, StudentsManagerState>(
      listener: _listener,
      child: Stack(
        children: [
          AnimatedList(
            key: _listKey,
            initialItemCount: students.length,
            padding: EdgeInsets.only(
              top: screenSize.height * 0.01,
              bottom: screenSize.height * 0.1,
              left: screenSize.width * 0.02,
              right: screenSize.width * 0.02,
            ),
            itemBuilder: (final context, final index, final animation) {
              final student = students[index];

              return _StudentListTile(
                student: student,
                onDelete: () => deleteStudent(student),
                onEdit: () {},
                animation: animation,
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
      ),
    );
  }

  void _listener(final BuildContext _, final StudentsManagerState state) {
    //TODO Handle states
    return switch (state) {
      (final StudentsManagerInitialState _) => null,
      (final StudentsManagerDeleteSuccessState state) =>
        removeFromList(state.student),
      (final StudentsManagerDeleteFailedState _) => null,
      (final StudentsManagerCreatedState state) =>
        insertIntoList(state.student),
      (final StudentsManagerUpdatedState _) => null,
    };
  }

  void insertIntoList(final StudentEntity student) {
    students.insert(0, student);
    _animatedList!.insertItem(0);
  }

  void removeFromList(final StudentEntity student) {
    final index = students.indexOf(student);

    if (index == -1) {
      return;
    }

    final removedItem = students.removeAt(index);

    _animatedList!.removeItem(
      index,
      (final context, final animation) {
        return _buildRemovedItem(
          removedItem,
          context,
          animation,
        );
      },
    );
  }

  Widget _buildRemovedItem(
    final StudentEntity student,
    final BuildContext context,
    final Animation<double> animation,
  ) {
    return _StudentListTile(
      student: student,
      onDelete: null,
      onEdit: null,
      animation: animation,
    );
  }
}
