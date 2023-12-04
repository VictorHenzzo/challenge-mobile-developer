import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/fetch_students_use_case.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_presenter.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_dependencies_event.dart';
part 'home_dependencies_state.dart';

@Injectable(as: HomeDependenciesPresenter)
class HomeDependenciesBloc
    extends Bloc<HomeDependenciesEvent, HomeDependenciesState>
    implements HomeDependenciesPresenter {
  HomeDependenciesBloc({
    required this.fetchStudentsUseCase,
  }) : super(const HomeDependenciesInitialState()) {
    on<HomeDependenciesFetchEvent>(_onHomeDependenciesFetchEvent);
  }

  final FetchStudentsUseCase fetchStudentsUseCase;

  Future<void> _onHomeDependenciesFetchEvent(
    final HomeDependenciesFetchEvent event,
    final Emitter<HomeDependenciesState> emit,
  ) async {
    emit(const HomeDependenciesLoadingState());

    final result = await fetchStudentsUseCase.fetchStudents();

    result.fold(
      onError: (final _) => emit(
        const HomeDependenciesErrorState(),
      ),
      onSuccess: (final _) => emit(
        HomeDependenciesLoadedState(result.valueOrNull!),
      ),
    );
  }

  @override
  void addEvent(final HomeDependenciesEvent event) {
    add(event);
  }
}
