import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../../../common/domain/entities/paginated_data_entity.dart';
import '../entities/book_entity.dart';

abstract class HomeRepository {
  Future<Either<AppFailure, PaginatedDataEntity<BookEntity>>> fetchBooks(
      [int? page]);
}
