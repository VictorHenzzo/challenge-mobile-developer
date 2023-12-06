part of '../home_screen.dart';

class _StudentsListWidget extends StatelessWidget {
  _StudentsListWidget({
    required final List<StudentEntity> students,
    required this.createStudent,
    required this.onDeleteTap,
    required this.editStudent,
    required this.onStudentCreated,
  })  : students = List.from(students),
        super(key: const Key('studentsListWidget'));

  final List<StudentEntity> students;
  final void Function({
    required BuildContext context,
    required StudentEntity student,
  }) onDeleteTap;
  final void Function(BuildContext context) onStudentCreated;
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
      (final StudentsManagerDeleteFailedState _) => _handleError(context),
      (final StudentsManagerDeleteSuccessState state) =>
        _handleRemove(state.student, context),
      (final StudentsManagerCreatedState state) =>
        _handleCreate(state.student, context),
      (final StudentsManagerUpdatedState state) =>
        _handleUpdate(state.student, context),
    };
  }

  void _handleError(final BuildContext context) {
    _showSnackBar(
      context: context,
      message:
          'Ops! Houve um erro ao deletar o estudante. Por favor, tente novamente',
      color: Theme.of(context).colorScheme.error,
    );
  }

  void _handleUpdate(final StudentEntity student, final BuildContext context) {
    final index = students.indexWhere(
      (final entry) => entry.id == student.id,
    );

    if (index == -1) {
      return;
    }

    _removeStudentFromList(index);
    _insertStudentIntoList(student, index);
    _showSnackBar(
      context: context,
      message: 'Estudante atualizado com sucesso',
      color: Colors.green,
    );
  }

  void _handleCreate(final StudentEntity student, final BuildContext context) {
    _insertStudentIntoList(student);
    onStudentCreated(context);
  }

  void _handleRemove(final StudentEntity student, final BuildContext context) {
    final index = students.indexOf(student);

    if (index == -1) {
      return;
    }

    _removeStudentFromList(index);
    _showSnackBar(
      context: context,
      message: 'Estudante removido com sucesso',
      color: Colors.green,
    );
  }

  void _insertStudentIntoList(
    final StudentEntity student, [
    final int index = 0,
  ]) {
    students.insert(index, student);
    _animatedList!.insertItem(index);
  }

  void _removeStudentFromList(final int index) {
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

  void _showSnackBar({
    required final BuildContext context,
    required final Color? color,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        message: message,
        color: color,
      ),
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
