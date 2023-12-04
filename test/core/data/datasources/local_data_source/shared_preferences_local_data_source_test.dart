import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/shared_preferences_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferencesLocalDataSource sut;
  late _SharedPreferencesSpy sharedPreferences;

  late String key;
  late String value;

  setUp(() {
    sharedPreferences = _SharedPreferencesSpy();
    sut = SharedPreferencesLocalDataSource(
      sharedPreferences: sharedPreferences,
    );

    key = 'key';
    value = 'value';
  });

  group('Save', () {
    void mockSave() {
      when(
        () => sharedPreferences.setString(any(), any()),
      ).thenAnswer((final _) async => true);
    }

    test('Should be able to call setString', () async {
      // arrange
      mockSave();

      // act
      await sut.save(key: key, value: value);

      // assert
      verify(() => sharedPreferences.setString(key, value)).called(1);
    });

    test('Should be able to return null on success', () async {
      // arrange
      mockSave();

      // act
      final result = await sut.save(key: key, value: value);

      // assert
      expect(result.hasValue, true);
      expect(result.hasError, false);
    });

    test('Should be able to return Failure if SharedPreferences throws',
        () async {
      // arrange
      when(
        () => sharedPreferences.setString(any(), any()),
      ).thenThrow(Exception('something went wront'));

      // act
      final result = await sut.save(key: key, value: value);

      // assert
      expect(result.hasValue, false);
      expect(result.hasError, true);
    });
  });

  group('Fetch', () {
    void mockFetch(final String? value) {
      when(
        () => sharedPreferences.getString(any()),
      ).thenAnswer((final _) => value);
    }

    test('Should be able to call getString', () async {
      // arrange
      mockFetch(value);

      // act
      await sut.fetch(key: key);

      // assert
      verify(() => sharedPreferences.getString(key)).called(1);
    });

    test('Should be able to return the correct value', () async {
      // arrange
      mockFetch(value);

      // act
      final result = await sut.fetch(key: key);

      // assert
      expect(result.valueOrNull, value);
    });

    test('Should be able to return null', () async {
      // arrange
      mockFetch(null);

      // act
      final result = await sut.fetch(key: key);

      // assert
      expect(result.valueOrNull, null);
      expect(result.hasValue, true);
      expect(result.hasError, false);
    });

    test('Should be able to return Failure if throws', () async {
      // arrange
      when(
        () => sharedPreferences.getString(any()),
      ).thenThrow(Exception('some exception'));

      // act
      final result = await sut.fetch(key: key);

      // assert
      expect(result.hasError, true);
      expect(result.hasValue, false);
    });
  });

  group('Delete', () {
    void mockDelete({
      required final bool value,
    }) {
      when(
        () => sharedPreferences.remove(any()),
      ).thenAnswer((final _) async => value);
    }

    test('Should be able to call remove', () async {
      // arrange
      mockDelete(value: true);

      // act
      await sut.delete(key: key);

      // assert
      verify(() => sharedPreferences.remove(key)).called(1);
    });

    test('Should be able to return success with the correct value if deleted',
        () async {
      // arrange
      mockDelete(value: true);

      // act
      final result = await sut.delete(key: key);

      // assert
      expect(result.valueOrNull, true);
    });

    test(
        "Should be able to return success with the correct value if deletion couldn't occur",
        () async {
      // arrange
      mockDelete(value: false);

      // act
      final result = await sut.delete(key: key);

      // assert
      expect(result.valueOrNull, false);
    });

    test('Should be able to return failure if shared preferences throws',
        () async {
      // arrange
      when(
        () => sharedPreferences.remove(any()),
      ).thenThrow(Exception());

      // act
      final result = await sut.delete(key: key);

      // assert
      expect(result.hasError, true);
      expect(result.hasValue, false);
    });
  });

  group('DeleteAll', () {
    void mockDeleteAll() {
      when(
        () => sharedPreferences.clear(),
      ).thenAnswer((final _) async => true);
    }

    test('Should be able to call clear', () async {
      // arrange
      mockDeleteAll();

      // act
      await sut.deleteAll();

      // assert
      verify(sharedPreferences.clear).called(1);
    });

    test('Should be able to return Success', () async {
      // arrange
      mockDeleteAll();

      // act
      final result = await sut.deleteAll();

      // assert
      expect(result.hasValue, true);
      expect(result.hasError, false);
    });

    test('Should be able to return Failure if throws', () async {
      // arrange
      when(
        () => sharedPreferences.clear(),
      ).thenThrow(Exception());

      // act
      final result = await sut.deleteAll();

      // assert
      expect(result.hasValue, false);
      expect(result.hasError, true);
    });
  });
}

class _SharedPreferencesSpy extends Mock implements SharedPreferences {}
