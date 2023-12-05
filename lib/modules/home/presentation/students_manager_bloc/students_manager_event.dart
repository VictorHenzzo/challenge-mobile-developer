part of 'students_manager_bloc.dart';

sealed class StudentsManagerEvent extends Equatable {
  const StudentsManagerEvent();

  @override
  List<Object> get props => [];
}

final class StudentsManagerDeleteEvent extends StudentsManagerEvent {
  const StudentsManagerDeleteEvent(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}

final class StudentsManagerDismissEvent extends StudentsManagerEvent {
  const StudentsManagerDismissEvent();
}

final class GoToCreateStudentEvent extends StudentsManagerEvent {
  const GoToCreateStudentEvent();
}

final class GoToEditStudentEvent extends StudentsManagerEvent {
  const GoToEditStudentEvent(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}
