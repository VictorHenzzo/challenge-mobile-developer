mixin ValidatorMixin {
  String? validateName(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyEmailMessage;
    }

    return null;
  }

  String? validateEmail(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyEmailMessage;
    }

    if (!validEmailRegExp.hasMatch(value!)) {
      return invalidEmailMessage;
    }

    return null;
  }

  String? validateAcademicRecord(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyAcademicRecordMessage;
    }

    return null;
  }

  String? validateCpf(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyCpfMessage;
    }

    if (cpfNumeric.hasMatch(value!)) {
      return null;
    }

    if (cpfWithOptions.hasMatch(value)) {
      return null;
    }

    return invalidCpfMessage;
  }

  String? validatePassword(final String? value) {
    if (value?.isEmpty ?? true) {
      return emptyPasswordMessage;
    }

    String errorList = '';

    if (value!.length < 8) {
      errorList += shortPasswordMessage;
    }

    if (!passwordUppercaseRegExp.hasMatch(value)) {
      errorList += uppercasePasswordMessage;
    }

    if (!passwordLowercaseRegExp.hasMatch(value)) {
      errorList += lowercasePasswordMessage;
    }

    if (!passwordDigitRegExp.hasMatch(value)) {
      errorList += digitPasswordMessage;
    }

    if (!passwordSpecialCharacterRegExp.hasMatch(value)) {
      errorList += specialCharacterPasswordMessage;
    }

    if (errorList.isEmpty) {
      return null;
    }

    return 'A senha deve ter $errorList';
  }

  // Error messages --------------------------------------------------------
  // Name
  static const String emptyNameMessage = 'Digite seu nome';

  // Cpf
  static const String emptyCpfMessage = 'Digite seu CPF';
  static const String invalidCpfMessage = 'Digite um CPF válido';

  // Email
  static const String emptyEmailMessage = 'Digite seu email';
  static const String invalidEmailMessage = 'Digite um email válido';

  // Academic record
  static const String emptyAcademicRecordMessage =
      'Digite o registro acadêmico';

  // Password
  static const String emptyPasswordMessage = 'Digite sua senha';
  static const String shortPasswordMessage = 'no mínimo 8 caracteres, ';
  static const String digitPasswordMessage = 'pelo menos um número, ';
  static const String uppercasePasswordMessage = 'uma letra maiúscula, ';
  static const String lowercasePasswordMessage = 'uma letra minúscula, ';
  static const String specialCharacterPasswordMessage =
      r'um caractere especial(@$!%*?&),';

  // Regex ------------------------------------------------------------------
  // Email
  static final RegExp validEmailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  // Cpf
  static final RegExp cpfNumeric = RegExp(r'^\d{11}$');
  static final RegExp cpfWithOptions = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');

  // Password
  static final RegExp passwordUppercaseRegExp = RegExp('(?=.*[A-Z])');
  static final RegExp passwordLowercaseRegExp = RegExp('(?=.*[a-z])');
  static final RegExp passwordDigitRegExp = RegExp(r'(?=.*\d)');
  static final RegExp passwordSpecialCharacterRegExp =
      RegExp(r'(?=.*[@$!%*?&])');
}
