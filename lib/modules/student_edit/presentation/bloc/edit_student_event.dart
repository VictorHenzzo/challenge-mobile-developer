part of 'edit_student_bloc.dart';

sealed class EditStudentEvent extends Equatable {
  const EditStudentEvent();
}

class RequestEditEvent extends EditStudentEvent {
  const RequestEditEvent({
    required this.params,
    required this.student,
  });

  final EditStudentParams params;
  final StudentEntity student;

  @override
  List<Object> get props => [params, student];
}

class RequestCreateEvent extends EditStudentEvent {
  const RequestCreateEvent(this.params);

  final CreateStudentParams params;

  @override
  List<Object> get props => [params];
}
