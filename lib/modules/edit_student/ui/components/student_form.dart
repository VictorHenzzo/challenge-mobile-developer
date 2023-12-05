part of '../student_edit_screen.dart';

class _StudentForm extends StatelessWidget with ValidatorMixin {
  const _StudentForm({
    required this.nameController,
    required this.cpfController,
    required this.academicRecordController,
    required this.emailController,
    required this.birthdateController,
    required this.formKey,
    required this.isLoading,
    required this.openDatePicker,
    required this.onSave,
  }) : super(key: const Key('studentForm'));

  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController academicRecordController;
  final TextEditingController emailController;
  final TextEditingController birthdateController;
  final bool isLoading;
  final GlobalKey<FormState> formKey;

  final VoidCallback onSave;
  final Future<void> Function(BuildContext) openDatePicker;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Dados do aluno',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: _EditStudentForm(
                controller: nameController,
                validator: validateName,
                keyboardType: TextInputType.name,
                label: 'Nome do aluno*',
                key: const Key('nameFormField'),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: _EditStudentForm(
                controller: birthdateController,
                keyboardType: TextInputType.name,
                label: 'Data de nascimento',
                suffixIcon: const Icon(Icons.today),
                onTap: () => openDatePicker(context),
                readOnly: true,
                key: const Key('birthdateFormField'),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: _EditStudentForm(
                validator: validateCpf,
                controller: cpfController,
                keyboardType: TextInputType.number,
                label: 'CPF*',
                key: const Key('cpfFormField'),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: _EditStudentForm(
                validator: validateAcademicRecord,
                controller: academicRecordController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                label: 'Registro acadêmico*',
                key: const Key('academicRecordFormField'),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: Text(
                'Dados de acesso',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: _EditStudentForm(
                validator: validateEmail,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'E-mail*',
                key: const Key('emailFormField'),
              ),
            ),
            _buildSpacing(),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: isLoading ? null : onSave,
                child: const Text('Salvar edições'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacing() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 15),
    );
  }
}

class _EditStudentForm extends StatelessWidget {
  const _EditStudentForm({
    required this.controller,
    required this.keyboardType,
    required this.label,
    this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    super.key,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      readOnly: readOnly,
      canRequestFocus: !readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.secondary,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
