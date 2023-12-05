part of 'students_manager_bloc.dart';

sealed class StudentsManagerEvent extends Equatable {
  const StudentsManagerEvent();

  @override
  List<Object> get props => [];
}

sealed class StudentsManagerDeleteEvent extends Equatable {
  const StudentsManagerDeleteEvent(this.student);

  final StudentEntity student;

  @override
  List<Object> get props => [student];
}
