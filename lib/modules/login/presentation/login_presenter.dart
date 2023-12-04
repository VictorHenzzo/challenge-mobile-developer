import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart';

abstract class LoginPresenter {
  void addEvent(final LoginEvent event);
}
