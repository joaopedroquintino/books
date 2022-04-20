import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

import '../../../modules/common/domain/entities/authentication_entity.dart';
import '../../domain/usecases/usecase.dart';
import '../dio/interceptors/authentication_interceptor.dart';

class DioFactory {
  DioFactory._();

  static const String _baseUrl = 'https://books.ioasys.com.br/api/v1';

  static Dio instance({
    required UseCase<AuthenticationEntity, dynamic> getAuthenticationUseCase,
    required UseCase<bool, dynamic> removeAuthenticationUseCase,
    required UseCase<AuthenticationEntity, dynamic> refreshTokenUseCase,
  }) {
    final Dio dio = Dio()
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout = 15000
      ..options.receiveTimeout = 15000
      ..options.contentType = Headers.jsonContentType
      ..interceptors.add(HttpFormatter());
    dio.interceptors.add(
      AuthenticationInterceptor(
        getAuthenticationUseCase: getAuthenticationUseCase,
        removeAuthenticationUseCase: removeAuthenticationUseCase,
        refreshTokenUseCase: refreshTokenUseCase,
        dio: dio,
      ),
    );

    return dio;
  }
}
