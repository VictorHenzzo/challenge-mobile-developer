part of '../login_screen.dart';

class _ForgotCredentialWidget extends StatelessWidget {
  const _ForgotCredentialWidget()
      : super(key: const Key('forgotCredentialWidget'));

  @override
  Widget build(final BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Esqueci o usuário'),
        ),
        const Text(
          'ou',
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Esqueci a senha'),
        ),
      ],
    );
  }
}
