import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/mixins/date_formatter_mixin.dart';
import 'package:challenge_mobile_developer/core/mixins/validator_mixin.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/bloc/edit_student_bloc.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/edit_student_presenter.dart';
import 'package:challenge_mobile_developer/widgets/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/student_form.dart';

class EditStudentScreen extends StatefulWidget {
  const EditStudentScreen({
    required this.student,
    required this.presenter,
  }) : super(key: const Key('editStudentScreen'));

  final StudentEntity? student;
  final EditStudentPresenter presenter;

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen>
    with DateFormatterMixin {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController cpfController;
  late final TextEditingController emailController;
  late final TextEditingController academicRecordController;
  late final TextEditingController birthdateController;
  late DateTime? birthdate;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.student?.name);
    cpfController = TextEditingController(text: widget.student?.cpf);
    emailController = TextEditingController(text: widget.student?.email);
    academicRecordController = TextEditingController(
      text: widget.student?.academicRecord,
    );

    birthdate = widget.student?.birthdate;

    birthdateController = TextEditingController(
      text: birthdate != null ? dateToDDMMYYYY(birthdate!) : null,
    );

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    emailController.dispose();
    academicRecordController.dispose();

    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: BlocConsumer<EditStudentBloc, EditStudentState>(
        listener: _listener,
        builder: (final _, final state) {
          return _StudentForm(
            nameController: nameController,
            cpfController: cpfController,
            academicRecordController: academicRecordController,
            emailController: emailController,
            birthdateController: birthdateController,
            formKey: formKey,
            openDatePicker: _openDatePicker,
            isLoading: state is EditStudentLoadingState,
            onSave: _onSave,
          );
        },
      ),
    );
  }

  Future<void> _openDatePicker(final BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      barrierColor: Colors.grey.withOpacity(0.8),
      helpText: 'Data de nascimento',
      initialDate: birthdate,
    );

    if (date == null) {
      return;
    }

    birthdate = date;
    birthdateController.text = dateToDDMMYYYY(birthdate!);
  }

  String get _appBarTitle =>
      widget.student == null ? 'Adicionar aluno' : 'Editar aluno';

  void _onSave() {
    final formIsValid = formKey.currentState?.validate() ?? false;
    if (!formIsValid) {
      return;
    }

    if (widget.student == null) {
      widget.presenter.addEvent(
        RequestCreateEvent(CreateStudentParams(
          name: nameController.text,
          email: emailController.text,
          birthdate: birthdate!,
          academicRecord: academicRecordController.text,
          cpf: cpfController.text,
        )),
      );
    }

    widget.presenter.addEvent(
      RequestEditEvent(
        params: EditStudentParams(
          name: nameController.text,
          email: emailController.text,
          birthdate: birthdate!,
        ),
        student: widget.student!,
      ),
    );
  }

  void _listener(final BuildContext context, final EditStudentState state) {
    if (state is StudentEditFailedState) {
      _showErrorSnackBar(
        context: context,
        message:
            'Ops! Houve um erro ao editar o estudante. Por favor, tente novamente',
      );
      return;
    }

    if (state is StudentCreationFailedState) {
      _showErrorSnackBar(
        context: context,
        message:
            'Ops! Houve um erro ao criar o estudante. Por favor, tente novamente',
      );
      return;
    }
  }

  void _showErrorSnackBar({
    required final BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ErrorSnackBar(
        errorMessage: message,
        theme: Theme.of(context),
      ),
    );
  }
}
