import 'package:flutter/services.dart';

class SqlSanitizerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) {
    final sanitizedText = sanitizeInput(newValue.text);

    return TextEditingValue(
      text: sanitizedText,
      selection: TextSelection.collapsed(offset: sanitizedText.length),
    );
  }

  String sanitizeInput(final String input) {
    return input.replaceAll(RegExp("[\"';]|(--)"), '');
  }
}
