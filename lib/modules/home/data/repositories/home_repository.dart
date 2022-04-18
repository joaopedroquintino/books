import 'package:dartz/dartz.dart';

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
  Future<Either<AppFailure, PaginatedDataEntity<BookEntity>>> fetchBooks(
      [int? page]) async {
    try {
      final data = await _datasource.fetchBooks(page);

      final paginatedData = PaginatedDataModel.fromMap(
        map: data.body!,
        itemMapper: BookModel.fromMap,
      );

      return Right(paginatedData);
    } catch (e) {
      return const Left(
        AppFailure(message: 'HomeRepository fetchBooks decode error'),
      );
    }
  }
}
