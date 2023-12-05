import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/edit_student_presenter.dart';
import 'package:flutter/material.dart';

class EditStudentScreen extends StatelessWidget {
  const EditStudentScreen({
    required this.student,
    required this.presenter,
  }) : super(key: const Key('editStudentScreen'));

  final StudentEntity? student;
  final EditStudentPresenter presenter;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
    );
  }

  String get _appBarTitle =>
      student == null ? 'Adicionar aluno' : 'Editar aluno';
}
