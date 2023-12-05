part of '../home_screen.dart';

class _AddNewStudentButtonWidget extends StatelessWidget {
  const _AddNewStudentButtonWidget({
    required this.onPressed,
  }) : super(key: const Key('addNewStudentButtonWidget'));

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.add),
          Text('Adicionar aluno'),
        ],
      ),
    );
  }
}
