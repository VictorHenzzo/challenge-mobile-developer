import 'package:challenge_mobile_developer/core/infra/either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Either<Exception, int> sut;
  late Exception exception;
  late int value;

  late _CallbackSpy<Exception, int> spy;

  setUp(() {
    exception = Exception('some exception');
    value = 1;

    spy = _CallbackSpy();

    registerFallbackValue(exception);
  });

  group('Success', () {
    setUp(() {
      sut = Success(value);
    });

    test('Should return the correct values on hasError and hasValue', () {
      // act
      final hasError = sut.hasError;
      final hasValue = sut.hasValue;

      // assert
      expect(hasError, false);
      expect(hasValue, true);
    });

    test('Should return value on valueOrNull', () {
      // act
      final result = sut.valueOrNull;

      // assert
      expect(result, value);
    });

    test('Should return null on errorOrNull', () {
      // act
      final result = sut.errorOrNull;

      // assert
      expect(result, null);
    });

    test('Should call onSuccess on fold', () {
      // arrange
      when(() => spy.onSuccess(any())).thenAnswer(
        (final _) => _,
      );

      // act
      sut.fold(
        onError: spy.onFailure,
        onSuccess: spy.onSuccess,
      );

      // assert
      verify(() => spy.onSuccess(value)).called(1);
      verifyNoMoreInteractions(spy);
    });
  });

  group('Failure', () {
    setUp(() {
      sut = Failure(exception);
    });

    test('Should return the correct values on hasError and hasValue', () {
      // act
      final hasError = sut.hasError;
      final hasValue = sut.hasValue;

      // assert
      expect(hasError, true);
      expect(hasValue, false);
    });

    test('Should return null value on valueOrNull', () {
      // act
      final result = sut.valueOrNull;

      // assert
      expect(result, null);
    });

    test('Should return exception on errorOrNull', () {
      // act
      final result = sut.errorOrNull;

      // assert
      expect(result, exception);
    });

    test('Should call onFailure on fold', () {
      // arrange
      when(() => spy.onFailure(any())).thenAnswer(
        (final _) => _,
      );

      // act
      sut.fold(
        onError: spy.onFailure,
        onSuccess: spy.onSuccess,
      );

      // assert
      verify(() => spy.onFailure(exception)).called(1);
      verifyNoMoreInteractions(spy);
    });
  });
}

class _CallbackSpy<F, S> extends Mock {
  void onFailure(final F value);
  void onSuccess(final S value);
}
