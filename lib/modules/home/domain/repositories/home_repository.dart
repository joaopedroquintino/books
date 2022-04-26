import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../../../common/domain/entities/paginated_data_entity.dart';
import '../entities/book_entity.dart';

abstract class HomeRepository {
  Future<Either<AppFailure, PaginatedDataEntity<BookEntity>>> fetchBooks({
    int? page,
    String? search,
  });

  Future<Either<AppFailure, BookEntity>> fetchBookDetails(String id);
  Future<Either<AppFailure, Unit>> favoriteBook(BookEntity book);
  Future<Either<AppFailure, Unit>> removeBookFromFavorites(BookEntity book);
  Future<Either<AppFailure, List<BookEntity>>> fetchFavoriteBooks();
}
