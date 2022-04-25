import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repository.dart';

class FetchFavoriteBooksUseCase extends UseCase<List<BookEntity>, dynamic> {
  FetchFavoriteBooksUseCase({required HomeRepository homeRepository})
      : _repository = homeRepository;

  final HomeRepository _repository;

  @override
  Future<Either<AppFailure, List<BookEntity>>> call([params]) async {
    return _repository.fetchFavoriteBooks();
  }
}
