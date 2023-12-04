import 'package:bloc/bloc.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_directions.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@Injectable(as: LoginPresenter)
class LoginBloc extends Bloc<LoginEvent, LoginState> implements LoginPresenter {
  LoginBloc({
    required this.checkAuthStateUseCase,
    required this.signInUseCase,
    required this.directions,
  }) : super(const LoginLoadingState()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
    on<RequestLoginEvent>(_onRequestLoginEvent);
  }

  Future<void> _onCheckAuthStatusEvent(
    final CheckAuthStatusEvent event,
    final Emitter<LoginState> emit,
  ) async {
    emit(const LoginCheckingAuthState());

    final authStatus = await checkAuthStateUseCase.check();

    switch (authStatus) {
      case AuthState.authenticated:
        return directions.goToHome();
      case AuthState.none:
        emit(const LoginLoadedState());
    }
  }

  Future<void> _onRequestLoginEvent(
    final RequestLoginEvent event,
    final Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoadingState());

    final result = await signInUseCase.signIn(
      email: event.email,
      password: event.password,
    );

    result.fold(
      onError: (final _) => emit(const LoginErrorState()),
      onSuccess: (final _) => directions.goToHome(),
    );
  }

  final CheckAuthStateUseCase checkAuthStateUseCase;
  final SignInUseCase signInUseCase;
  final LoginScreenDirections directions;

  @override
  void addEvent(final LoginEvent event) {
    add(event);
  }
}
