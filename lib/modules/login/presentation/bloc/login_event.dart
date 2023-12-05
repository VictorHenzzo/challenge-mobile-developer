part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class RequestSignInEvent extends LoginEvent {
  const RequestSignInEvent({
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
