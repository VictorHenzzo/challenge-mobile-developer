import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  const StudentEntity({
    required this.academicRecord,
    required this.name,
    required this.email,
    required this.birthdate,
    required this.cpf,
    required this.createdAt,
    required this.id,
  });

  final String academicRecord;
  final String name;
  final String email;
  final DateTime birthdate;
  final DateTime createdAt;
  final String cpf;
  final String id;

  @override
  List<Object?> get props => [
        academicRecord,
        name,
        email,
        birthdate,
        createdAt,
        cpf,
        id,
      ];
}
