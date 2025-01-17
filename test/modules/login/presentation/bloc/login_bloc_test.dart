import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mobile_developer/core/data/models/user_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/user_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/check_auth_state_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/sign_in_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/modules/login/navigation/login_screen_directions.dart';
import 'package:challenge_mobile_developer/modules/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late LoginBloc sut;
  late _CheckAuthStateUseCaseSpy checkAuthStateUseCase;
  late _SignInUseCaseSpy signInUseCase;
  late _LoginScreenDirectionsSpy directions;

  late String email;
  late String password;

  setUp(() {
    checkAuthStateUseCase = _CheckAuthStateUseCaseSpy();
    signInUseCase = _SignInUseCaseSpy();
    directions = _LoginScreenDirectionsSpy();
    sut = LoginBloc(
      checkAuthStateUseCase: checkAuthStateUseCase,
      signInUseCase: signInUseCase,
      directions: directions,
    );

    email = 'some@mail.example';
    password = 'password';
  });

  test('Should have a initial state', () async {
    expect(sut.state, const LoginLoadingState());
  });

  group('CheckAuthStatusEvent', () {
    blocTest(
      'Should be able to call CheckAuthStateUseCase',
      setUp: () {
        when(checkAuthStateUseCase.check).thenAnswer(
          (final _) async => AuthState.none,
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const CheckAuthStatusEvent()),
      verify: (final _) {
        verify(checkAuthStateUseCase.check).called(1);

        verifyNoMoreInteractions(signInUseCase);
      },
    );

    blocTest(
      'Should call directions.goToHome if checkAuthState returns AuthState.authenticated',
      setUp: () {
        when(checkAuthStateUseCase.check).thenAnswer(
          (final _) async => AuthState.authenticated,
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const CheckAuthStatusEvent()),
      verify: (final _) {
        verify(directions.goToHome).called(1);
      },
      expect: () => const [LoginCheckingAuthState()],
    );

    blocTest(
      'Should emit LoginLoadedState if checkAuthState returns AuthState.none',
      setUp: () {
        when(checkAuthStateUseCase.check).thenAnswer(
          (final _) async => AuthState.none,
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const CheckAuthStatusEvent()),
      verify: (final _) {
        verifyNoMoreInteractions(directions);
      },
      expect: () => const [
        LoginCheckingAuthState(),
        LoginLoadedState(),
      ],
    );
  });

  group('RequestSignInEvent', () {
    void mockSignIn(
      final Either<AppError, UserEntity> result,
    ) {
      when(
        () => signInUseCase.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((final _) async => result);
    }

    blocTest(
      'Should be able to call SignInUseCase',
      setUp: () {
        mockSignIn(Success(UserModel.empty()));
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestSignInEvent(
          email: email,
          password: password,
        ),
      ),
      verify: (final _) {
        verify(
          () => signInUseCase.signIn(
            email: email,
            password: password,
          ),
        ).called(1);

        verifyNoMoreInteractions(checkAuthStateUseCase);
      },
    );

    blocTest(
      'Should call directions.goToHome if SignInUseCase returns Success',
      setUp: () {
        mockSignIn(Success(UserModel.empty()));
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestSignInEvent(
          email: email,
          password: password,
        ),
      ),
      verify: (final _) {
        verify(directions.goToHome).called(1);
      },
      expect: () => const [LoginLoadingState()],
    );

    blocTest(
      'Should call emit SignInFailedState if SignInUseCase returns Failure',
      setUp: () {
        mockSignIn(Failure(AppError.empty()));
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestSignInEvent(
          email: email,
          password: password,
        ),
      ),
      verify: (final _) {
        verifyNoMoreInteractions(directions);
      },
      expect: () => const [
        LoginLoadingState(),
        SignInFailedState(),
      ],
    );
  });
}

class _CheckAuthStateUseCaseSpy extends Mock implements CheckAuthStateUseCase {}

class _SignInUseCaseSpy extends Mock implements SignInUseCase {}

class _LoginScreenDirectionsSpy extends Mock implements LoginScreenDirections {}
