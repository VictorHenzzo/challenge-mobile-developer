import 'package:challenge_mobile_developer/core/formatters/sql_sanitizer_input_formatter.dart';
import 'package:challenge_mobile_developer/core/mixins/validator_mixin.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/login_presenter.dart';
import 'package:challenge_mobile_developer/shared/assets.dart';
import 'package:challenge_mobile_developer/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/email_form_field_widget.dart';
part 'components/password_form_field_widget.dart';
part 'components/forgot_credential_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    required this.presenter,
  }) : super(key: const Key('loginScreen')) {
    presenter.addEvent(const CheckAuthStatusEvent());
  }

  final LoginPresenter presenter;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (final context, final state) {
          switch (state.runtimeType) {
            case LoginCheckingAuthState:
              return const CustomLoadingWidget();

            default:
              return _LoginScreenBody(
                onSignIn: onSignIn,
                passwordController: TextEditingController(),
                emailController: TextEditingController(),
              );
          }
        },
      ),
    );
  }

  void onSignIn({
    required final String email,
    required final String password,
  }) {}
}

class _LoginScreenBody extends StatelessWidget {
  _LoginScreenBody({
    required this.onSignIn,
    required this.emailController,
    required this.passwordController,
  }) : super(key: const Key('loginScreenBody'));

  final void Function({
    required String email,
    required String password,
  }) onSignIn;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Image.asset(
              Assets.icon,
            ),
            const Spacer(),
            _EmailFormFieldWidget(emailController: emailController),
            const SizedBox(height: 15),
            _PasswordFormFieldWidget(passwordController: passwordController),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: _ForgotCredentialWidget(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: onPressed,
              child: const Text('Cadastrar'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    final formIsValid = formKey.currentState?.validate() ?? false;
    if (!formIsValid) {
      return;
    }
  }
}
