import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

enum AuthState {
  authenticated,
  none;
}

abstract class CheckAuthStateUseCase {
  Future<AuthState> check();
}

@injectable
class CheckAuthStateUseCaseImpl implements CheckAuthStateUseCase {
  CheckAuthStateUseCaseImpl(this.userRepository);

  final UserRepository userRepository;

  @override
  Future<AuthState> check() async {
    final localUser = await _getLocalUser();

    if (localUser == null) {
      return AuthState.none;
    }

    final remoteUser = await _getUserById(localUser.id);
    return localUser == remoteUser ? AuthState.authenticated : AuthState.none;
  }

  Future<UserEntity?> _getLocalUser() async => userRepository
      .getUserFromLocal()
      .then((final userEither) => userEither.valueOrNull);

  Future<UserEntity?> _getUserById(final String id) => userRepository
      .getUserById(id)
      .then((final userEither) => userEither.valueOrNull);
}
