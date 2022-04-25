import '../../../../core/api/errors/app_exception.dart';
import '../../../../core/api/interface/http.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../../../packages/data/interface/data_return.dart';
import '../../domain/datasources/home_datasource.dart';
import '../models/book_model.dart';

class HomeDataSourceImpl implements HomeDataSource {
  HomeDataSourceImpl({
    required Http http,
    required LocalStorage database,
  })  : _http = http,
        _localStorage = database;

  final Http _http;
  final LocalStorage _localStorage;

  static String booksUrl(int? page, String? search) =>
      '/books?ammount=25${page != null ? '&page=$page' : ''}${(search?.isNotEmpty ?? false) ? '&page=$search' : ''}';

  static String bookDetailsUrl(String id) => '/books/$id';
  static const String _collectionName = 'favorite_books';

  @override
  Future<DataReturn> fetchBooks({int? page, String? search}) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        booksUrl(page, search),
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

  @override
  Future<DataReturn> fetchBookDetails(String id) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        bookDetailsUrl(id),
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

  @override
  Future<bool> favoriteBook(BookModel book) async {
    try {
      final result = await _localStorage.insert(
        _collectionName,
        book.toMap(),
      );
      return result.data as bool;
    } catch (e) {
      return false;
    }
  }
}
