import 'package:challenge_mobile_developer/core/infra/navigation/app_navigator.dart';
import 'package:challenge_mobile_developer/modules/home/navigation/home_screen_route.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginScreenDirections {
  void goToHome() {
    const AppNavigator().pushNamedAndRemoveAll(
      HomeScreenRoute.path,
    );
  }
}
