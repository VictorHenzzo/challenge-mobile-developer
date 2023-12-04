enum HttpMethod { get, post, delete }

class HttpResponse {
  HttpResponse({required this.body, required this.statusCode});

  final String body;
  final int statusCode;
}

abstract class HttpDataSource {
  const HttpDataSource();

  Future<HttpResponse> request({
    required final String url,
    required final HttpMethod method,
    final Map<String, dynamic>? body,
  });
}
