mixin ValidatorMixin {
  static final RegExp validEmailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  static const String emptyEmailMessage = 'Digite seu email';
  static const String invalidEmailMessage = 'Digite um email válido';

  String? validateEmail(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyEmailMessage;
    }

    if (!validEmailRegExp.hasMatch(value!)) {
      return invalidEmailMessage;
    }

    return null;
  }

  static final RegExp uppercaseRegExp = RegExp('(?=.*[A-Z])');
  static final RegExp lowercaseRegExp = RegExp('(?=.*[a-z])');
  static final RegExp digitRegExp = RegExp(r'(?=.*\d)');
  static final RegExp specialCharacterRegExp = RegExp(r'(?=.*[@$!%*?&])');

  static const String emptyPasswordMessage = 'Digite sua senha';
  static const String shortPasswordMessage = 'no mínimo 8 caracteres, ';
  static const String digitPasswordMessage = 'pelo menos um número, ';
  static const String uppercasePasswordMessage = 'uma letra maiúscula, ';
  static const String lowercasePasswordMessage = 'uma letra minúscula, ';
  static const String specialCharacterPasswordMessage =
      r'um caractere especial(@$!%*?&),';

  String? validatePassword(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyPasswordMessage;
    }

    String errorList = '';

    if (value!.length < 8) {
      errorList += shortPasswordMessage;
    }

    if (!uppercaseRegExp.hasMatch(value)) {
      errorList += uppercasePasswordMessage;
    }

    if (!lowercaseRegExp.hasMatch(value)) {
      errorList += lowercasePasswordMessage;
    }

    if (!digitRegExp.hasMatch(value)) {
      errorList += digitPasswordMessage;
    }

    if (!specialCharacterRegExp.hasMatch(value)) {
      errorList += specialCharacterPasswordMessage;
    }

    if (errorList.isEmpty) {
      return null;
    }

    return 'A senha deve ter $errorList';
  }
}
