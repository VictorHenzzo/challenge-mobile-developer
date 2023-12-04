part of '../login_screen.dart';

class _EmailFormFieldWidget extends StatelessWidget with ValidatorMixin {
  const _EmailFormFieldWidget({
    required this.emailController,
  }) : super(key: const Key('emailFormFieldWidget'));

  final TextEditingController emailController;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: emailController,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      inputFormatters: [SqlSanitizerInputFormatter()],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: const Text('Usuário'),
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.secondary,
        ),
        prefixIcon: const Icon(
          Icons.person_outline,
        ),
      ),
    );
  }
}
