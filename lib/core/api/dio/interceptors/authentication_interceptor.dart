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
  });

  final UseCase<AuthenticationEntity, dynamic> getAuthenticationUseCase;
  final UseCase<bool, dynamic> removeAuthenticationUseCase;

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
        await removeAuthenticationUseCase();
        // Refresh token call in future.
        Modular.to.navigate(
          LoginRouteNamed.login.fullPath,
        );
      }
    }
    handler.next(err);
  }

  Map<String, dynamic> headers(String token) {
    return <String, dynamic>{
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
