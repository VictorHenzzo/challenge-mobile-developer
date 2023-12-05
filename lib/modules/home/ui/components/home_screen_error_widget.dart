part of '../home_screen.dart';

class _HomeScreenErrorWidget extends StatelessWidget {
  const _HomeScreenErrorWidget({
    required this.tryAgain,
  }) : super(key: const Key('homeScreenErrorWidget'));

  final VoidCallback tryAgain;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Icon(
          Icons.error,
          size: screenSize.height * 0.2,
          color: theme.colorScheme.error,
        ),
        const SizedBox(height: 15),
        Text(
          'Ops! Houve um erro ao carregar este conteúdo',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          'Por favor, verifique sua conexão com a internet e tente novamente.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: ElevatedButton(
            onPressed: tryAgain,
            child: const Text('Recarregar conteúdo'),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
