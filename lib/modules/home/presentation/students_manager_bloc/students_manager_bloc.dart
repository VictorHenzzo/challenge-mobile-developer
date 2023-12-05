import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_presenter.dart';
import 'package:equatable/equatable.dart';

part 'students_manager_event.dart';
part 'students_manager_state.dart';

class StudentsManagerBloc
    extends Bloc<StudentsManagerEvent, StudentsManagerState>
    implements StudentsManagerPresenter {
  StudentsManagerBloc() : super(const StudentsManagerInitialState()) {
    on<StudentsManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  void addEvent(final StudentsManagerEvent event) {
    add(event);
  }
}
