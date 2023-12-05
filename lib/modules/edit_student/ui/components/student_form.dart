part of '../student_edit_screen.dart';

class _StudentForm extends StatelessWidget with ValidatorMixin {
  const _StudentForm({
    required this.nameController,
    required this.cpfController,
    required this.academicRecordController,
    required this.emailController,
    required this.formKey,
    required this.isLoading,
    required this.onSave,
  }) : super(key: const Key('studentForm'));

  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController academicRecordController;
  final TextEditingController emailController;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados do aluno',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 15),
            _EditStudentForm(
              controller: nameController,
              validator: validateName,
              keyboardType: TextInputType.name,
              label: 'Nome do aluno*',
              key: const Key('nameFormField'),
            ),
            const SizedBox(height: 15),
            _EditStudentForm(
              validator: validateCpf,
              controller: cpfController,
              keyboardType: TextInputType.number,
              label: 'CPF*',
              key: const Key('cpfFormField'),
            ),
            const SizedBox(height: 15),
            _EditStudentForm(
              validator: validateAcademicRecord,
              controller: academicRecordController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              label: 'Registro acadêmico*',
              key: const Key('academicRecordFormField'),
            ),
            const SizedBox(height: 15),
            Text(
              'Dados de acesso',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 15),
            _EditStudentForm(
              validator: validateEmail,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              label: 'E-mail*',
              key: const Key('emailFormField'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: isLoading ? null : onSave,
              child: const Text('Salvar edições'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _EditStudentForm extends StatelessWidget {
  const _EditStudentForm({
    required this.validator,
    required this.controller,
    required this.keyboardType,
    required this.label,
    this.inputFormatters,
    super.key,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String label;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
