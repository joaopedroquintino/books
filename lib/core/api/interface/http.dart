import 'http_response.dart';

abstract class Http {
  Future<HttpResponse<T>> post<T>(
    String url,
    body, {
    Map<String, String>? headers,
    String? contentType,
  });

  Future<HttpResponse<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
  });
}
