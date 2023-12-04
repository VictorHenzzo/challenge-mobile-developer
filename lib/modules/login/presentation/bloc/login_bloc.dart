import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_directions.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> implements LoginPresenter {
  LoginBloc({
    required this.checkAuthStateUseCase,
    required this.signInUseCase,
    required this.directions,
  }) : super(const LoginLoadingState()) {}

  final CheckAuthStateUseCase checkAuthStateUseCase;
  final SignInUseCase signInUseCase;
  final LoginScreenDirections directions;

  @override
  void addEvent(final LoginEvent event) {
    add(event);
  }
}
