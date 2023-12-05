import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/infra/service_locator/service_locator.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/edit_student_presenter.dart';
import 'package:challenge_mobile_developer/modules/edit_student/presentation/bloc/edit_student_bloc.dart';
import 'package:challenge_mobile_developer/modules/edit_student/ui/student_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditStudentScreenRoute {
  static const String path = '/edit-student';

  static Route of(final StudentEntity? student) {
    final presenter = const ServiceLocator().get<EditStudentPresenter>();

    return MaterialPageRoute(
      builder: (final _) {
        return BlocProvider<EditStudentBloc>(
          create: (final _) => presenter as EditStudentBloc,
          child: EditStudentScreen(
            presenter: presenter,
            student: student,
          ),
        );
      },
    );
  }
}
