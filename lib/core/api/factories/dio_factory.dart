import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

class DioFactory {
  DioFactory._();

  static const String _baseUrl = 'https://books.ioasys.com.br/api/v1';

  static final CacheOptions _cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: <int>[401, 403],
    maxStale: const Duration(days: 2),
    priority: CachePriority.normal,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  static Dio instance() {
    final Dio dio = Dio()
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout = 15000
      ..options.receiveTimeout = 15000
      ..options.contentType = Headers.jsonContentType
      ..interceptors.add(
        DioCacheInterceptor(options: _cacheOptions),
      )
      ..interceptors.add(HttpFormatter());

    return dio;
  }
}
