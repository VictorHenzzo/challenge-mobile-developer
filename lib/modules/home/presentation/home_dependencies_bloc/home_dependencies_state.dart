part of 'home_dependencies_bloc.dart';

sealed class HomeDependenciesState extends Equatable {
  const HomeDependenciesState();

  @override
  List<Object> get props => [];
}

final class HomeDependenciesInitialState extends HomeDependenciesState {
  const HomeDependenciesInitialState();
}

final class HomeDependenciesLoadingState extends HomeDependenciesState {
  const HomeDependenciesLoadingState();
}

final class HomeDependenciesLoadedState extends HomeDependenciesState {
  const HomeDependenciesLoadedState(
    this.students,
  );

  final List<StudentEntity> students;

  @override
  List<Object> get props => [students];
}

final class HomeDependenciesErrorState extends HomeDependenciesState {
  const HomeDependenciesErrorState();
}
