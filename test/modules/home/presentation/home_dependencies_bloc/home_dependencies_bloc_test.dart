import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/fetch_students_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/home_dependencies_bloc/home_dependencies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late HomeDependenciesBloc sut;
  late FetchStudentsUseCaseSpy fetchStudentsUseCase;

  late List<StudentEntity> students;

  setUp(() {
    fetchStudentsUseCase = FetchStudentsUseCaseSpy();
    sut = HomeDependenciesBloc(fetchStudentsUseCase: fetchStudentsUseCase);

    students = [StudentModel.empty()];
  });

  void mockFetchStudents(
    final Either<AppError, List<StudentEntity>> result,
  ) {
    when(
      fetchStudentsUseCase.fetchStudents,
    ).thenAnswer((final _) async => result);
  }

  group('HomeDependenciesFetchEvent', () {
    blocTest(
      'Should be able to call fetchStudentsUseCase',
      setUp: () => mockFetchStudents(Success(students)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        const HomeDependenciesFetchEvent(),
      ),
      verify: (final _) {
        verify(fetchStudentsUseCase.fetchStudents).called(1);
      },
    );

    blocTest(
      'Should be able to emmit loaded state if fetchStudentsUseCase returns Success',
      setUp: () => mockFetchStudents(Success(students)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        const HomeDependenciesFetchEvent(),
      ),
      expect: () => [
        const HomeDependenciesLoadingState(),
        HomeDependenciesLoadedState(students),
      ],
    );

    blocTest(
      'Should be able to emmit error state if fetchStudentsUseCase returns Failure',
      setUp: () => mockFetchStudents(Failure(AppError.empty())),
      build: () => sut,
      act: (final bloc) => bloc.add(
        const HomeDependenciesFetchEvent(),
      ),
      expect: () => const [
        HomeDependenciesLoadingState(),
        HomeDependenciesErrorState(),
      ],
    );
  });
}

class FetchStudentsUseCaseSpy extends Mock implements FetchStudentsUseCase {}
