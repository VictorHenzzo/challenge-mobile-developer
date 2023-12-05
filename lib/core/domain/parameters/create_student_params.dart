import 'package:challenge_mobile_developer/core/mixins/date_formatter_mixin.dart';
import 'package:equatable/equatable.dart';

class CreateStudentParams extends Equatable with DateFormatterMixin {
  const CreateStudentParams({
    required this.name,
    required this.email,
    required this.birthdate,
    required this.academicRecord,
    required this.cpf,
  });

  final String name;
  final String email;
  final DateTime birthdate;
  final String academicRecord;
  final String cpf;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthdate': dateToYYYYMMDD(birthdate),
        'academic_record': academicRecord,
        'cpf': cpf,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        birthdate,
        academicRecord,
        cpf,
      ];
}
