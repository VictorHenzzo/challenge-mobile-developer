import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mobile_developer/core/data/models/student_model.dart';
import 'package:challenge_mobile_developer/core/domain/entities/student_entity.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/create_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/parameters/edit_student_params.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/create_student_use_case.dart';
import 'package:challenge_mobile_developer/core/domain/use_cases/edit_student_use_case.dart';
import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:challenge_mobile_developer/core/infra/errors/app_error.dart';
import 'package:challenge_mobile_developer/modules/student_edit/navigation/student_edit_directions.dart';
import 'package:challenge_mobile_developer/modules/student_edit/presentation/bloc/edit_student_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late EditStudentBloc sut;
  late _StudentEditDirectionsSpy directions;
  late _CreateStudentUseCaseSpy createStudentUseCase;
  late _EditStudentUseCaseSpy editStudentUseCase;

  late StudentEntity student;
  late EditStudentParams editParams;
  late CreateStudentParams createParams;

  setUp(() {
    directions = _StudentEditDirectionsSpy();
    createStudentUseCase = _CreateStudentUseCaseSpy();
    editStudentUseCase = _EditStudentUseCaseSpy();
    sut = EditStudentBloc(
      directions: directions,
      createStudentUseCase: createStudentUseCase,
      editStudentUseCase: editStudentUseCase,
    );

    student = StudentModel.empty();
    editParams = EditStudentParams(
      name: 'name',
      email: 'email@example.com',
      birthdate: DateTime(1983, 11, 10),
    );
    createParams = CreateStudentParams(
      name: 'name',
      email: 'email@example.com',
      birthdate: DateTime(1983, 11, 10),
      academicRecord: '1234',
      cpf: '12312312300',
    );

    registerFallbackValue(student);
    registerFallbackValue(createParams);
    registerFallbackValue(editParams);

    when(() => directions.goBack(any())).thenAnswer(
      (final _) async => _,
    );
  });

  void mockCreateStudent(
    final Either<AppError, StudentEntity> result,
  ) {
    when(() => createStudentUseCase.create(any())).thenAnswer(
      (final _) async => result,
    );
  }

  void mockEditStudent(
    final Either<AppError, StudentEntity> result,
  ) {
    when(
      () => editStudentUseCase.edit(
        id: any(named: 'id'),
        params: any(named: 'params'),
      ),
    ).thenAnswer((final _) async => result);
  }

  group('RequestCreateEvent', () {
    blocTest(
      'Should be able to call createStudentUseCase',
      setUp: () => mockCreateStudent(Success(student)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestCreateEvent(createParams),
      ),
      verify: (final _) {
        verify(() => createStudentUseCase.create(createParams)).called(1);

        verifyNoMoreInteractions(editStudentUseCase);
      },
    );

    blocTest(
      'Should be able to call directions.goBack if createStudentUseCase returns Success',
      setUp: () => mockCreateStudent(Success(student)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestCreateEvent(createParams),
      ),
      expect: () => const [EditStudentLoadingState()],
      verify: (final _) {
        verify(() => directions.goBack(student)).called(1);
      },
    );

    blocTest(
      'Should be able to emmit StudentCreationFailedState if createStudentUseCase returns Failure',
      setUp: () => mockCreateStudent(Failure(AppError.empty())),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestCreateEvent(createParams),
      ),
      expect: () => const [
        EditStudentLoadingState(),
        StudentCreationFailedState(),
      ],
      verify: (final _) {
        verifyNoMoreInteractions(directions);
      },
    );
  });

  group('RequestEditEvent', () {
    blocTest(
      'Should be able to call editStudentUseCase',
      setUp: () => mockEditStudent(Success(student)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestEditEvent(
          params: editParams,
          student: student,
        ),
      ),
      verify: (final _) {
        verify(
          () => editStudentUseCase.edit(
            id: student.id,
            params: editParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(createStudentUseCase);
      },
    );

    blocTest(
      'Should be able to call directions.goBack if editStudentUseCase returns Success',
      setUp: () => mockEditStudent(Success(student)),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestEditEvent(
          params: editParams,
          student: student,
        ),
      ),
      expect: () => const [EditStudentLoadingState()],
      verify: (final _) {
        verify(() => directions.goBack(student)).called(1);
      },
    );

    blocTest(
      'Should be able to emmit StudentEditFailedState if editStudentUseCase returns Failure',
      setUp: () => mockEditStudent(Failure(AppError.empty())),
      build: () => sut,
      act: (final bloc) => bloc.add(
        RequestEditEvent(
          params: editParams,
          student: student,
        ),
      ),
      expect: () => const [
        EditStudentLoadingState(),
        StudentEditFailedState(),
      ],
      verify: (final _) {
        verifyNoMoreInteractions(directions);
      },
    );
  });
}

class _StudentEditDirectionsSpy extends Mock implements StudentEditDirections {}

class _CreateStudentUseCaseSpy extends Mock implements CreateStudentUseCase {}

class _EditStudentUseCaseSpy extends Mock implements EditStudentUseCase {}
