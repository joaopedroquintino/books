import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../../../common/domain/entities/paginated_data_entity.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repository.dart';

class FetchBooksUseCase extends UseCase<PaginatedDataEntity<BookEntity>, int?> {
  FetchBooksUseCase({required HomeRepository homeRepository})
      : _repository = homeRepository;

  final HomeRepository _repository;

  @override
  Future<Either<AppFailure, PaginatedDataEntity<BookEntity>>> call(
      [int? params]) async {
    return _repository.fetchBooks(params);
  }
}
