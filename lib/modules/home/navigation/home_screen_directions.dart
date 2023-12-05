import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/infra/navigation/app_navigator.dart';
import 'package:challenge_mobile_developer/modules/edit_student/navigation/edit_student_screen_route.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenDirections {
  Future<StudentEntity?> toEditStudent({final StudentEntity? student}) async {
    final result = await const AppNavigator().pushNamed(
      EditStudentScreenRoute.path,
      arguments: student,
    );

    return result as StudentEntity?;
  }

  void dismiss() {
    const AppNavigator().pop();
  }
}
