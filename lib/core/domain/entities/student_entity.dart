import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  const StudentEntity({
    required this.academicRecord,
    required this.name,
    required this.email,
    required this.birthdate,
    required this.cpf,
  });

  final String academicRecord;
  final String name;
  final String email;
  final DateTime birthdate;
  final String cpf;

  @override
  List<Object?> get props => [
        academicRecord,
        name,
        email,
        birthdate,
        cpf,
      ];
}
