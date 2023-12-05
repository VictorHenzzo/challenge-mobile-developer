import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/modules/student_edit/edit_student_presenter.dart';
import 'package:equatable/equatable.dart';

part 'edit_student_event.dart';
part 'edit_student_state.dart';

class EditStudentBloc extends Bloc<EditStudentEvent, EditStudentState>
    implements EditStudentPresenter {
  EditStudentBloc() : super(EditStudentInitialState()) {
    on<EditStudentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  void addEvent(final EditStudentEvent event) {
    add(event);
  }
}
