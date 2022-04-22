import '../../../../core/api/errors/app_exception.dart';
import '../../../../core/api/interface/http.dart';
import '../../../../packages/data/interface/data_return.dart';
import '../../domain/datasources/home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  HomeDataSourceImpl({required Http http}) : _http = http;

  final Http _http;

  static String booksUrl(int? page) =>
      '/books?ammount=25${page != null ? '&page=$page' : ''}';

  @override
  Future<DataReturn> fetchBooks([int? page]) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        booksUrl(page),
      );

      return DataSuccess(body: response.body);
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
