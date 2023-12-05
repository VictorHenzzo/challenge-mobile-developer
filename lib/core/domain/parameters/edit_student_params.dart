import 'package:challenge_mobile_developer/core/mixins/date_formatter_mixin.dart';
import 'package:equatable/equatable.dart';

class EditStudentParams extends Equatable with DateFormatterMixin {
  const EditStudentParams({
    required this.name,
    required this.email,
    required this.birthdate,
  });

  final String? name;
  final String? email;
  final DateTime? birthdate;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (name != null) {
      json['name'] = name;
    }

    if (email != null) {
      json['email'] = email;
    }

    if (birthdate != null) {
      json['birthdate'] = formatDateToString(birthdate!);
    }

    return json;
  }

  @override
  List<Object?> get props => [
        name,
        email,
        birthdate,
      ];
}
