part of 'home_dependencies_bloc.dart';

sealed class HomeDependenciesEvent extends Equatable {
  const HomeDependenciesEvent();

  @override
  List<Object> get props => [];
}

final class HomeDependenciesFetchEvent extends HomeDependenciesEvent {
  const HomeDependenciesFetchEvent();
}
