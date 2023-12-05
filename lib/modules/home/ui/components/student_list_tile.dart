part of '../home_screen.dart';

class _StudentListTile extends StatelessWidget {
  const _StudentListTile({
    required this.student,
    required this.onEdit,
    required this.onDelete,
    required this.animation,
  });

  final StudentEntity student;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Animation<double> animation;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    final titleTextStyle = theme.textTheme.labelLarge?.copyWith(
      color: theme.colorScheme.secondary,
    );

    final subtitleTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.secondary,
    );

    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: SizedBox(
          height: screenSize.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: _studentInformation(
                    titleTextStyle: titleTextStyle,
                    subtitleTextStyle: subtitleTextStyle,
                  ),
                ),
                _actionButtons(
                  color: theme.colorScheme.secondary,
                  size: screenSize.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _studentInformation({
    required final TextStyle? titleTextStyle,
    required final TextStyle? subtitleTextStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          student.name,
          style: titleTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          student.academicRecord,
          style: subtitleTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'CPF: ${student.cpf}',
          style: subtitleTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _actionButtons({
    required final Color color,
    required final double size,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onEdit,
          child: Icon(
            Icons.edit,
            color: color,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onDelete,
          child: Icon(
            Icons.delete_outline,
            color: color,
          ),
        ),
      ],
    );
  }
}
