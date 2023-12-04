import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/infra/environment/environment_config.dart';
import 'package:challenge_mobile_developer/core/infra/errors/http_error.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
final class HttpDataSourceAdapter implements HttpDataSource {
  HttpDataSourceAdapter(this.client);

  final http.Client client;

  String get _baseUrl => EnvironmentConfig.baseUrl;

  @override
  Future<HttpResponse> request({
    required final String url,
    required final HttpMethod method,
    final Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(_baseUrl + url);

    final response = await _handleRequest(
      url: uri,
      method: method,
      body: body,
    );

    return _handleResponse(response);
  }

  Future<http.Response> _handleRequest({
    required final Uri url,
    required final HttpMethod method,
    required final Map<String, dynamic>? body,
  }) async {
    switch (method) {
      case HttpMethod.get:
        return client.get(url);
      case HttpMethod.post:
        return client.post(url, body: body);
      case HttpMethod.delete:
        return client.delete(url);
    }
  }

  HttpResponse _handleResponse(final http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return HttpResponse(
          body: response.body,
          statusCode: response.statusCode,
        );

      case 400:
        throw BadRequest(message: response.body);
      case 404:
        throw NotFound(message: response.body);

      default:
        throw ServerError(message: response.body);
    }
  }
}
