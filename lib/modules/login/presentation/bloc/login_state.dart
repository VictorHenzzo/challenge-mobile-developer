part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginCheckingAuthState extends LoginState {
  const LoginCheckingAuthState();
}

final class LoginLoadedState extends LoginState {
  const LoginLoadedState();
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginErrorState extends LoginState {
  const LoginErrorState();
}
