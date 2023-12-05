part of '../home_screen.dart';

class _StudentsListWidget extends StatelessWidget {
  _StudentsListWidget({
    required final List<StudentEntity> students,
    required this.createStudent,
    required this.onDeleteTap,
    required this.editStudent,
  })  : students = List.from(students),
        super(key: const Key('studentsListWidget'));

  final List<StudentEntity> students;
  final void Function({
    required BuildContext context,
    required StudentEntity student,
  }) onDeleteTap;
  final VoidCallback createStudent;
  final void Function(StudentEntity) editStudent;

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
            itemBuilder: (final _, final index, final animation) {
              final student = students[index];

              return _StudentListTile(
                student: student,
                onDelete: () => onDeleteTap(context: context, student: student),
                onEdit: () => editStudent(student),
                animation: animation,
              );
            },
          ),
          Positioned(
            bottom: 15,
            left: screenSize.width * 0.20,
            right: screenSize.width * 0.20,
            child: _AddNewStudentButtonWidget(
              onPressed: createStudent,
            ),
          ),
        ],
      ),
    );
  }

  void _listener(final BuildContext context, final StudentsManagerState state) {
    return switch (state) {
      (final StudentsManagerInitialState _) => null,
      (final StudentsManagerDeleteSuccessState state) =>
        removeFromList(state.student),
      (final StudentsManagerDeleteFailedState _) => _showErrorSnackBar(
          context: context,
          message:
              'Ops! Houve um erro ao deletar o estudante. Por favor, tente novamente',
        ),
      (final StudentsManagerCreatedState state) =>
        insertIntoList(state.student),
      (final StudentsManagerUpdatedState _) => null,
    };
  }

  void _showErrorSnackBar({
    required final BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ErrorSnackBar(
        errorMessage: message,
        theme: Theme.of(context),
      ),
    );
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
