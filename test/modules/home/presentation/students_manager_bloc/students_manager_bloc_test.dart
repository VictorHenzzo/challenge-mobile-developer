import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/delete_student_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/modules/home/navigation/home_screen_directions.dart';
import 'package:challenge_mobile_developer/modules/home/presentation/students_manager_bloc/students_manager_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late StudentsManagerBloc sut;
  late _DeleteStudentUseCaseSpy deleteStudentUseCase;
  late _HomeScreenDirectionsSpy directions;

  late StudentEntity student;

  setUp(() {
    deleteStudentUseCase = _DeleteStudentUseCaseSpy();
    directions = _HomeScreenDirectionsSpy();

    sut = StudentsManagerBloc(
      deleteStudentUseCase: deleteStudentUseCase,
      directions: directions,
    );

    student = StudentModel.empty();
  });

  void mockDirectionsToEditStudent(final StudentEntity? student) {
    when(
      () => directions.toEditStudent(
        student: any(named: 'student'),
      ),
    ).thenAnswer((final _) async => student);
  }

  group('StudentsManagerDeleteEvent', () {
    void mockDeleteUser(
      final Either<AppError, void> result,
    ) {
      when(() => deleteStudentUseCase.delete(any())).thenAnswer(
        (final _) async => result,
      );
    }

    blocTest(
      'Should be able to call deleteStudentUseCase',
      setUp: () => mockDeleteUser(const Success(null)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        StudentsManagerDeleteEvent(student),
      ),
      verify: (final _) {
        verify(
          () => deleteStudentUseCase.delete(student.id),
        ).called(1);
      },
    );

    blocTest(
      'Should emit StudentsManagerDeleteSuccessState if deleteStudentUseCase returns Success',
      setUp: () => mockDeleteUser(const Success(null)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        StudentsManagerDeleteEvent(student),
      ),
      expect: () => [StudentsManagerDeleteSuccessState(student)],
    );

    blocTest(
      'Should emit StudentsManagerDeleteSuccessState if deleteStudentUseCase returns Failure',
      setUp: () => mockDeleteUser(Failure(AppError.empty())),
      build: () => sut,
      act: (final bloc) => bloc.add(
        StudentsManagerDeleteEvent(student),
      ),
      expect: () => [StudentsManagerDeleteFailedState(student)],
    );
  });

  group('StudentsManagerDismissEvent', () {
    blocTest(
      'Should call directions dismiss',
      setUp: () {
        when(directions.dismiss).thenAnswer(
          (final _) async => _,
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        const StudentsManagerDismissEvent(),
      ),
      expect: () => [],
    );
  });

  group('GoToCreateStudentEvent', () {
    blocTest(
      'Should call directions.toEditStudent',
      setUp: () {
        mockDirectionsToEditStudent(null);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        const GoToCreateStudentEvent(),
      ),
      verify: (final _) {
        verify(() => directions.toEditStudent()).called(1);
      },
    );

    blocTest(
      'If directions.toEditStudent returns a Student, shoud emit StudentsManagerCreatedState',
      setUp: () {
        mockDirectionsToEditStudent(student);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        const GoToCreateStudentEvent(),
      ),
      expect: () => [
        StudentsManagerCreatedState(student),
      ],
    );

    blocTest(
      'If directions.toEditStudent returns null, should not emit any events',
      setUp: () {
        mockDirectionsToEditStudent(null);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        const GoToCreateStudentEvent(),
      ),
      expect: () => [],
    );
  });

  group('StudentsManagerUpdatedState', () {
    blocTest(
      'Should call directions.toEditStudent',
      setUp: () {
        mockDirectionsToEditStudent(null);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        GoToEditStudentEvent(student),
      ),
      verify: (final _) {
        verify(
          () => directions.toEditStudent(student: student),
        ).called(1);
      },
    );

    blocTest(
      'If directions.toEditStudent returns a Student, shoud emit StudentsManagerUpdatedState',
      setUp: () {
        mockDirectionsToEditStudent(student);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        GoToEditStudentEvent(student),
      ),
      expect: () => [
        StudentsManagerUpdatedState(student),
      ],
    );

    blocTest(
      'If directions.toEditStudent returns null, should not emit any events',
      setUp: () {
        mockDirectionsToEditStudent(null);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        GoToEditStudentEvent(student),
      ),
      expect: () => [],
    );
  });
}

class _DeleteStudentUseCaseSpy extends Mock implements DeleteStudentUseCase {}

class _HomeScreenDirectionsSpy extends Mock implements HomeScreenDirections {}
