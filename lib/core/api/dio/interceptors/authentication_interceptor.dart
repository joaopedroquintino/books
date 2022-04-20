import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../modules/common/domain/entities/authentication_entity.dart';
import '../../../../modules/login/login_routing.dart';
import '../../../domain/usecases/usecase.dart';

class AuthenticationInterceptor implements Interceptor {
  AuthenticationInterceptor({
    required this.getAuthenticationUseCase,
    required this.removeAuthenticationUseCase,
    required this.refreshTokenUseCase,
    required this.dio,
  });

  final UseCase<AuthenticationEntity, dynamic> getAuthenticationUseCase;
  final UseCase<bool, dynamic> removeAuthenticationUseCase;
  final UseCase<AuthenticationEntity, dynamic> refreshTokenUseCase;
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token;

    final result = await getAuthenticationUseCase.call(unit);
    result.fold((l) => null, (r) {
      token = r.authorization;
    });

    final hasToken = token != null;
    final hasHeader = options.headers.containsKey(
      HttpHeaders.authorizationHeader,
    );

    if (hasToken && !hasHeader) {
      options.headers.addAll(headers(token!));
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final Map<String, dynamic>? data =
          err.response?.data as Map<String, dynamic>?;
      final message = (data?['errors'] as Map?)?['message'];
      if (message == 'Não autorizado.') {
        try {
          await removeAuthenticationUseCase();
          final reqOptions = err.requestOptions;
          await refreshToken();
          _retry(reqOptions);
        } catch (e) {
          Modular.to.navigate(
            LoginRouteNamed.login.fullPath,
          );
        }
      }
    }
    handler.next(err);
  }

  Future<void> refreshToken() async {
    final result = await getAuthenticationUseCase();

    await result.fold((l) => null, (auth) async {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/refresh-token',
        data: {
          'refreshToken': auth.refreshToken,
        },
      );
    });
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Map<String, dynamic> headers(String token) {
    return <String, dynamic>{
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
