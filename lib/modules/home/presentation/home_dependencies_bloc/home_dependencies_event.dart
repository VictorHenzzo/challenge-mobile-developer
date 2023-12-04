part of 'home_dependencies_bloc.dart';

sealed class HomeDependenciesEvent extends Equatable {
  const HomeDependenciesEvent();

  @override
  List<Object> get props => [];
}

sealed class HomeDependenciesFetchEvent extends HomeDependenciesEvent {
  const HomeDependenciesFetchEvent();
}
