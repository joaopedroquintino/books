import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import '../interface/http.dart';
import '../interface/http_response.dart';

class HttpDio extends Http {
  HttpDio({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<HttpResponse<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final Response<T> response = await dio.get<T>(
        url,
        options: Options(
          headers: headers,
          contentType: contentType,
        ),
      );

      return HttpResponse(
        body: response.data,
        headers: _modifyDioHeader(response.headers.map),
        statusCode: response.statusCode,
      );
    } on DioError catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String url,
    body, {
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final Response<T> response = await dio.post<T>(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: contentType,
        ),
      );

      return HttpResponse(
        body: response.data,
        headers: _modifyDioHeader(response.headers.map),
        statusCode: response.statusCode,
      );
    } on DioError catch (e) {
      if (e.response != null &&
          (e.response!.statusCode == 401 || e.response!.statusCode == 400)) {
        final Map<String, dynamic> body =
            e.response!.data as Map<String, dynamic>;
        if (body.containsKey('errors')) {
          final List<Map<String, dynamic>> errors =
              List.castFrom<dynamic, Map<String, dynamic>>(
            body['errors'] as List,
          );
          throw AppException(
            message: errors[0]['message'] as String,
            code: errors[0]['code'] as String,
          );
        }
      }
      rethrow;
    }
  }

  /// This method modify headers because the returns is <String,List<String>>
  /// instead of <String,String>.
  Map<String, String> _modifyDioHeader(Map<String, List<String>> headers) {
    return headers.map<String, String>(
      (String key, List<String> value) {
        return MapEntry<String, String>(
          key,
          value[0],
        );
      },
    );
  }
}
