import 'package:dartz/dartz.dart';

import '../../../../packages/data/interface/data_return.dart';
import '../../../../shared/errors/app_failure.dart';
import '../../../common/data/models/paginated_data_model.dart';
import '../../../common/domain/entities/paginated_data_entity.dart';
import '../../domain/datasources/home_datasource.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/book_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeDataSource homeDataSource,
  }) : _datasource = homeDataSource;

  final HomeDataSource _datasource;

  @override
  Future<Either<AppFailure, PaginatedDataEntity<BookEntity>>> fetchBooks({
    int? page,
    String? search,
  }) async {
    try {
      final data = await _datasource.fetchBooks(page: page, search: search);

      if (data is DataSuccess) {
        final paginatedData = PaginatedDataModel.fromMap(
          map: data.body as Map<String, dynamic>,
          itemMapper: BookModel.fromMap,
        );

        return Right(paginatedData);
      } else {
        return Left(
          AppFailure(
            message: data.message,
          ),
        );
      }
    } catch (e) {
      return const Left(
        AppFailure(message: 'HomeRepository fetchBooks decode error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, BookEntity>> fetchBookDetails(String id) async {
    try {
      final data = await _datasource.fetchBookDetails(id);

      if (data is DataSuccess) {
        final book = BookModel.fromMap(data.body as Map<String, dynamic>);

        return Right(book);
      } else {
        return Left(
          AppFailure(
            message: data.message,
          ),
        );
      }
    } catch (e) {
      return const Left(
        AppFailure(message: 'HomeRepository fetchBookDetails decode error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, Unit>> favoriteBook(BookEntity book) async {
    try {
      final result = await _datasource.favoriteBook(book as BookModel);
      if (result) {
        return const Right(unit);
      }
      return const Left(AppFailure());
    } catch (e) {
      return const Left(AppFailure());
    }
  }

  @override
  Future<Either<AppFailure, List<BookModel>>> fetchFavoriteBooks() async {
    try {
      final result = await _datasource.fetchFavoriteBooks();
      if (result == null) {
        return const Left(AppFailure());
      } else {
        final books = result.map((e) => BookModel.fromMap(e)).toList();
        return Right(books);
      }
    } catch (e) {
      return const Left(AppFailure());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> removeBookFromFavorites(
      BookEntity book) async {
    try {
      final result =
          await _datasource.removeBookFromFavorites(book as BookModel);
      if (result) {
        return const Right(unit);
      }
      return const Left(AppFailure());
    } catch (e) {
      return const Left(AppFailure());
    }
  }
}
