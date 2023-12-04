part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class RequestLoginEvent extends LoginEvent {
  const RequestLoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class CheckAuthStatusEvent extends LoginEvent {
  const CheckAuthStatusEvent();

  @override
  List<Object> get props => [];
}
