part of '../home_screen.dart';

class _ConfirmStudentDeletionAlertDialog extends StatelessWidget {
  const _ConfirmStudentDeletionAlertDialog({
    required this.dismiss,
    required this.onConfirm,
    required this.student,
  }) : super(key: const Key('confirmStudentDeletionAlertDialog'));

  final VoidCallback dismiss;
  final void Function(StudentEntity) onConfirm;
  final StudentEntity student;

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir aluno'),
      content: const Text(
        'Tem certeza que deseja exluir este aluno? Todas as informações dele serão apagadas',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: dismiss,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(student);
            dismiss();
          },
          child: const Text('Excluir aluno'),
        ),
      ],
    );
  }
}
