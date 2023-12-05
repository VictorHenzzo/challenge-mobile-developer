part of 'students_manager_bloc.dart';

sealed class StudentsManagerState extends Equatable {
  const StudentsManagerState();

  @override
  List<Object> get props => [];
}

final class StudentsManagerInitialState extends StudentsManagerState {
  const StudentsManagerInitialState();
}

final class StudentsManagerDeletedState extends StudentsManagerState {
  const StudentsManagerDeletedState(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}

final class StudentsManagerCreatedState extends StudentsManagerState {
  const StudentsManagerCreatedState(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}

final class StudentsManagerUpdatedState extends StudentsManagerState {
  const StudentsManagerUpdatedState(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}