import '../../../../core/api/errors/app_exception.dart';
import '../../../../core/api/interface/http.dart';
import '../../../../packages/data/interface/data_return.dart';
import '../../domain/datasources/login_datasource.dart';
import '../dto/login_dto.dart';

class LoginDatasourceImpl implements LoginDatasource {
  LoginDatasourceImpl({
    required this.http,
  });

  final Http http;

  static const String url = '/auth/sign-in';

  @override
  Future<DataReturn> authenticate(LoginDTO dto) async {
    try {
      final result = await http.post<Map<String, dynamic>>(
        url,
        dto.toJson(),
      );

      return DataSuccess(
        body: result.body,
        headers: result.headers,
      );
    } on AppException catch (e) {
      return DataError(
        message: e.message,
      );
    } catch (e) {
      return DataError(
        message: 'Ocorreu um erro inesperado',
      );
    }
  }
}
