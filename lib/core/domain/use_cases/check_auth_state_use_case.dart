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

    if (remoteUser == null) {
      return AuthState.none;
    }

    if (localUser == remoteUser) {
      return AuthState.authenticated;
    }

    return AuthState.none;
  }

  Future<UserEntity?> _getLocalUser() async {
    final result = await userRepository.getUserFromLocal();

    return result.valueOrNull;
  }

  Future<UserEntity?> _getUserById(final String id) async {
    final result = await userRepository.getUserById(id);

    return result.valueOrNull;
  }
}
