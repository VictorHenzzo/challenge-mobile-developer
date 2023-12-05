import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required super.academicRecord,
    required super.name,
    required super.email,
    required super.birthdate,
    required super.createdAt,
    required super.cpf,
    required super.id,
  });

  factory StudentModel.fromJson(final Map<String, dynamic> json) {
    return StudentModel(
      academicRecord: json['academic_record'],
      name: json['name'],
      email: json['email'],
      birthdate: DateTime.parse(json['birthdate']),
      createdAt: DateTime.parse(json['createdAt']),
      cpf: json['cpf'],
      id: json['id'],
    );
  }

  factory StudentModel.empty() {
    return StudentModel(
      academicRecord: 'academicRecord',
      name: 'name',
      email: 'email',
      birthdate: DateTime.now(),
      createdAt: DateTime.now(),
      cpf: 'cpf',
      id: 'id',
    );
  }
}
