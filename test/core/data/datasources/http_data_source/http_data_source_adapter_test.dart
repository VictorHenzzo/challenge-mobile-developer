import 'dart:convert';

import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source_adapter.dart';
import 'package:challenge_mobile_developer/core/infra/environment/environment_config.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

void main() {
  late HttpDataSourceAdapter sut;
  late _ClientSpy client;

  late String baseUrl;
  late String url;
  late Uri formattedUrl;
  late Map<String, dynamic>? body;

  setUp(() {
    client = _ClientSpy();
    sut = HttpDataSourceAdapter(client);

    baseUrl = EnvironmentConfig.baseUrl;
    url = '/someEndpoint';
    formattedUrl = Uri.parse('$baseUrl$url');
    body = {'someKey': 'someValue'};

    registerFallbackValue(formattedUrl);
  });

  void mockGet(final String body, final int statusCode) {
    when(() => client.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (final _) async => http.Response(body, statusCode),
    );
  }

  void mockPost(final String body, final int statusCode) {
    when(
      () => client.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (final _) async => http.Response(body, statusCode),
    );
  }

  void mockPut(final String body, final int statusCode) {
    when(
      () => client.put(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (final _) async => http.Response(body, statusCode),
    );
  }

  void mockDelete(final String body, final int statusCode) {
    when(
      () => client.delete(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (final _) async => http.Response(body, statusCode),
    );
  }

  group('GET', () {
    group('Success', () {
      test('Should be able to make a GET request with the correct values',
          () async {
        // arrange
        mockGet('body', 200);

        // act
        await sut.request(
          url: url,
          method: HttpMethod.get,
        );

        // assert
        verify(
          () => client.get(
            formattedUrl,
            headers: HttpDataSourceAdapter.defaultHeaders,
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      });

      test('Should be able to return HttpResponse on 200 status code',
          () async {
        // arrange
        mockGet('body', 200);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.get,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 200);
      });
    });

    group('Failure', () {
      test('Should be able to throw BadRequest on 400', () async {
        // arrange
        mockGet('error', 400);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.get,
        );

        // assert
        expect(request, throwsA(const BadRequest(message: 'error')));
      });

      test('Should be able to throw NotFound on 404', () async {
        // arrange
        mockGet('error', 404);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.get,
        );

        // assert
        expect(request, throwsA(const NotFound(message: 'error')));
      });

      test('Should be able to throw ServerError on 500', () async {
        // arrange
        mockGet('error', 500);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.get,
        );

        // assert
        expect(request, throwsA(const ServerError(message: 'error')));
      });
    });
  });

  group('POST', () {
    group('Success', () {
      test('Should be able to make a POST request with the correct values',
          () async {
        // arrange
        mockPost('body', 200);

        // act
        await sut.request(
          url: url,
          body: body,
          method: HttpMethod.post,
        );

        // assert
        verify(
          () => client.post(
            formattedUrl,
            body: jsonEncode(body),
            headers: HttpDataSourceAdapter.defaultHeaders,
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      });

      test('Should be able to return HttpResponse on 200 status code',
          () async {
        // arrange
        mockPost('body', 200);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.post,
          body: body,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 200);
      });

      test('Should be able to return HttpResponse on 201 status code',
          () async {
        // arrange
        mockPost('body', 201);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.post,
          body: body,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 201);
      });
    });

    group('Failure', () {
      test('Should be able to throw BadRequest on 400', () async {
        // arrange
        mockPost('error', 400);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.post,
        );

        // assert
        expect(request, throwsA(const BadRequest(message: 'error')));
      });

      test('Should be able to throw NotFound on 404', () async {
        // arrange
        mockPost('error', 404);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.post,
        );

        // assert
        expect(request, throwsA(const NotFound(message: 'error')));
      });

      test('Should be able to throw ServerError on 500', () async {
        // arrange
        mockPost('error', 500);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.post,
        );

        // assert
        expect(request, throwsA(const ServerError(message: 'error')));
      });
    });
  });

  group('DELETE', () {
    group('Success', () {
      test('Should be able to make a DELETE request with the correct values',
          () async {
        // arrange
        mockDelete('body', 200);

        // act
        await sut.request(
          url: url,
          method: HttpMethod.delete,
        );

        // assert
        verify(
          () => client.delete(
            formattedUrl,
            headers: HttpDataSourceAdapter.defaultHeaders,
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      });

      test('Should be able to return HttpResponse on 200 status code',
          () async {
        // arrange
        mockDelete('body', 200);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.delete,
          body: body,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 200);
      });
    });

    group('Failure', () {
      test('Should be able to throw BadRequest on 400', () async {
        // arrange
        mockDelete('error', 400);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.delete,
        );

        // assert
        expect(request, throwsA(const BadRequest(message: 'error')));
      });

      test('Should be able to throw NotFound on 404', () async {
        // arrange
        mockDelete('error', 404);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.delete,
        );

        // assert
        expect(request, throwsA(const NotFound(message: 'error')));
      });

      test('Should be able to throw ServerError on 500', () async {
        // arrange
        mockDelete('error', 500);

        // act
        final request = sut.request(
          url: url,
          method: HttpMethod.delete,
        );

        // assert
        expect(request, throwsA(const ServerError(message: 'error')));
      });
    });
  });

  group('PUT', () {
    group('Success', () {
      test('Should be able to make a PUT request with the correct values',
          () async {
        // arrange
        mockPut('body', 200);

        // act
        await sut.request(
          url: url,
          body: body,
          method: HttpMethod.put,
        );

        // assert
        verify(
          () => client.put(
            formattedUrl,
            body: jsonEncode(body),
            headers: HttpDataSourceAdapter.defaultHeaders,
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      });

      test('Should be able to return HttpResponse on 200 status code',
          () async {
        // arrange
        mockPut('body', 200);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.put,
          body: body,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 200);
      });

      test('Should be able to return HttpResponse on 201 status code',
          () async {
        // arrange
        mockPut('body', 201);

        // act
        final result = await sut.request(
          url: url,
          method: HttpMethod.put,
          body: body,
        );

        // assert
        expect(result.body, 'body');
        expect(result.statusCode, 201);
      });
    });

    group('Failure', () {
      test('Should be able to throw BadRequest on 400', () async {
        // arrange
        mockPut('error', 400);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.put,
        );

        // assert
        expect(request, throwsA(const BadRequest(message: 'error')));
      });

      test('Should be able to throw NotFound on 404', () async {
        // arrange
        mockPut('error', 404);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.put,
        );

        // assert
        expect(request, throwsA(const NotFound(message: 'error')));
      });

      test('Should be able to throw ServerError on 500', () async {
        // arrange
        mockPut('error', 500);

        // act
        final request = sut.request(
          url: url,
          body: body,
          method: HttpMethod.put,
        );

        // assert
        expect(request, throwsA(const ServerError(message: 'error')));
      });
    });
  });
}

class _ClientSpy extends Mock implements http.Client {}
