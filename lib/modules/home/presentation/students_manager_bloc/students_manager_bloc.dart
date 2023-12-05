import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/delete_student_use_case.dart';
import 'package:challenge_mobile_developer/modules/home/navigation/home_screen_directions.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_presenter.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'students_manager_event.dart';
part 'students_manager_state.dart';

@Injectable(as: StudentsManagerPresenter)
class StudentsManagerBloc
    extends Bloc<StudentsManagerEvent, StudentsManagerState>
    implements StudentsManagerPresenter {
  StudentsManagerBloc({
    required this.deleteStudentUseCase,
    required this.directions,
  }) : super(const StudentsManagerInitialState()) {
    on<StudentsManagerDeleteEvent>(_onStudentsManagerDeleteEvent);
    on<StudentsManagerDismissEvent>(_onStudentsManagerDismissEvent);
  }

  final DeleteStudentUseCase deleteStudentUseCase;
  final HomeScreenDirections directions;

  Future<void> _onStudentsManagerDeleteEvent(
    final StudentsManagerDeleteEvent event,
    final Emitter<StudentsManagerState> emit,
  ) async {
    final result = await deleteStudentUseCase.delete(event.student.id);

    result.fold(
      onError: (final _) => emit(
        StudentsManagerDeleteFailedState(event.student),
      ),
      onSuccess: (final _) => emit(
        StudentsManagerDeleteSuccessState(event.student),
      ),
    );
  }

  Future<void> _onStudentsManagerDismissEvent(
    final StudentsManagerDismissEvent event,
    final Emitter<StudentsManagerState> emit,
  ) async {
    directions.dismiss();
  }

  @override
  void addEvent(final StudentsManagerEvent event) {
    add(event);
  }
}
