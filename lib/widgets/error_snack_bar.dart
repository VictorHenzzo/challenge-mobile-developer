import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({
    required final String errorMessage,
    required final ThemeData theme,
    super.key,
  }) : super(
          content: Text(errorMessage),
          backgroundColor: theme.colorScheme.error,
        );
}
