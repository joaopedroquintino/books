import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../modules/common/data/models/authentication_model.dart';
import '../../../../modules/common/domain/entities/authentication_entity.dart';
import '../../../../modules/login/login_routing.dart';
import '../../../domain/usecases/usecase.dart';
import '../utils/modify_dio_header.dart';

class AuthenticationInterceptor implements Interceptor {
  AuthenticationInterceptor({
    required this.getAuthenticationUseCase,
    required this.removeAuthenticationUseCase,
    required this.saveAuthenticationUseCase,
    required this.dio,
  });

  final UseCase<AuthenticationEntity, dynamic> getAuthenticationUseCase;
  final UseCase<bool, dynamic> removeAuthenticationUseCase;
  final UseCase<bool, AuthenticationEntity> saveAuthenticationUseCase;
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

          final response = await dio.fetch(reqOptions);
          handler.resolve(response);
        } catch (e) {
          Modular.to.navigate(
            LoginRouteNamed.login.fullPath,
          );
          handler.next(err);
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
      await saveAuthenticationUseCase(
        AuthenticationModel.fromJson(
          modifyDioHeader(response.headers.map),
        ),
      );
    });
  }

  Map<String, dynamic> headers(String token) {
    return <String, dynamic>{
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
