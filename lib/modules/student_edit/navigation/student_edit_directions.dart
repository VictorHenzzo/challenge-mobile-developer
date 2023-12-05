import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/infra/navigation/app_navigator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StudentEditDirections {
  void goBack(final StudentEntity student) {
    const AppNavigator().pop(
      result: student,
    );
  }
}
