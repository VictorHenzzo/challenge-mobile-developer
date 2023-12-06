import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required final String message,
    required final Color? color,
    super.key,
  }) : super(
          content: Text(message),
          backgroundColor: color,
        );
}
