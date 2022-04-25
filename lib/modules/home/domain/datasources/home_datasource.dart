import '../../../../packages/data/interface/data_return.dart';
import '../../data/models/book_model.dart';

abstract class HomeDataSource {
  Future<DataReturn> fetchBooks({int? page, String? search});
  Future<DataReturn> fetchBookDetails(String id);
  Future<bool> favoriteBook(BookModel book);
}
