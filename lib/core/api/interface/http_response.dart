class HttpResponse<T> {
  HttpResponse({
    this.body,
    this.headers,
    this.statusCode,
  });

  final Map<String, dynamic>? headers;
  final T? body;
  final int? statusCode;
}
