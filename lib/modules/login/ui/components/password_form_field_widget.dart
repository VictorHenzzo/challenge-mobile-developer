part of '../login_screen.dart';

// ignore: must_be_immutable
class _PasswordFormFieldWidget extends StatelessWidget with ValidatorMixin {
  _PasswordFormFieldWidget({
    required this.passwordController,
  }) : super(key: const Key('passwordFormFieldWidget'));

  final TextEditingController passwordController;
  bool showPassword = false;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return StatefulBuilder(
      builder: (final _, final setState) {
        return TextFormField(
          controller: passwordController,
          validator: validatePassword,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.secondary,
          ),
          inputFormatters: [SqlSanitizerInputFormatter()],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: !showPassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock_outline,
            ),
            labelStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
            ),
            label: const Text('Senha'),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: const Icon(
                Icons.remove_red_eye_outlined,
              ),
            ),
          ),
        );
      },
    );
  }
}
