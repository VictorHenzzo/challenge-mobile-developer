import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/create_student_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/edit_student_use_case.dart';
import 'package:challenge_mobile_developer/modules/student_edit/edit_student_presenter.dart';
import 'package:challenge_mobile_developer/modules/student_edit/navigation/student_edit_directions.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'edit_student_event.dart';
part 'edit_student_state.dart';

@Injectable(as: EditStudentPresenter)
class EditStudentBloc extends Bloc<EditStudentEvent, EditStudentState>
    implements EditStudentPresenter {
  EditStudentBloc({
    required this.directions,
    required this.createStudentUseCase,
    required this.editStudentUseCase,
  }) : super(const EditStudentInitialState()) {
    on<EditStudentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final StudentEditDirections directions;
  final CreateStudentUseCase createStudentUseCase;
  final EditStudentUseCase editStudentUseCase;

  @override
  void addEvent(final EditStudentEvent event) {
    add(event);
  }
}
