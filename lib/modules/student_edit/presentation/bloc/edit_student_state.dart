part of 'edit_student_bloc.dart';

sealed class EditStudentState extends Equatable {
  const EditStudentState();
  
  @override
  List<Object> get props => [];
}

final class EditStudentInitial extends EditStudentState {}
