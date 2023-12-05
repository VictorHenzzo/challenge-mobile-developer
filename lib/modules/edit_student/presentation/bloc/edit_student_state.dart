part of 'edit_student_bloc.dart';

sealed class EditStudentState extends Equatable {
  const EditStudentState();

  @override
  List<Object> get props => [];
}

final class EditStudentInitialState extends EditStudentState {
  const EditStudentInitialState();
}

final class EditStudentLoadingState extends EditStudentState {
  const EditStudentLoadingState();
}

final class StudentEditFailedState extends EditStudentState {
  const StudentEditFailedState();
}

final class StudentCreationFailedState extends EditStudentState {
  const StudentCreationFailedState();
}
