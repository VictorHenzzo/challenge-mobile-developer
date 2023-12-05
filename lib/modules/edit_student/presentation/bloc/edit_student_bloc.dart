import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/create_student_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/edit_student_use_case.dart';
import 'package:challenge_mobile_developer/modules/edit_student/navigation/student_edit_directions.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/edit_student_presenter.dart';
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
    on<RequestCreateEvent>(_onRequestCreateEvent);
    on<RequestEditEvent>(_onRequestEditEvent);
  }

  final EditStudentScreenDirections directions;
  final CreateStudentUseCase createStudentUseCase;
  final EditStudentUseCase editStudentUseCase;

  Future<void> _onRequestCreateEvent(
    final RequestCreateEvent event,
    final Emitter<EditStudentState> emit,
  ) async {
    emit(const EditStudentLoadingState());

    final result = await createStudentUseCase.create(
      event.params,
    );

    result.fold(
      onError: (final _) => emit(const StudentCreationFailedState()),
      onSuccess: directions.goBack,
    );
  }

  Future<void> _onRequestEditEvent(
    final RequestEditEvent event,
    final Emitter<EditStudentState> emit,
  ) async {
    emit(const EditStudentLoadingState());

    final result = await editStudentUseCase.edit(
      id: event.student.id,
      params: event.params,
    );

    result.fold(
      onError: (final _) => emit(const StudentEditFailedState()),
      onSuccess: directions.goBack,
    );
  }

  @override
  void addEvent(final EditStudentEvent event) {
    add(event);
  }
}
