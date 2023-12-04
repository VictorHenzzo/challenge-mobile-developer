import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required super.academicRecord,
    required super.name,
    required super.email,
    required super.birthdate,
    required super.cpf,
  });

  factory StudentModel.fromJson(final Map<String, dynamic> json) {
    return StudentModel(
      academicRecord: json['academicRecord'],
      name: json['name'],
      email: json['email'],
      birthdate: DateTime.parse(json['birthdate']),
      cpf: json['cpf'],
    );
  }

  factory StudentModel.empty() {
    return StudentModel(
      academicRecord: '',
      name: '',
      email: '',
      birthdate: DateTime.now(),
      cpf: '',
    );
  }
}
