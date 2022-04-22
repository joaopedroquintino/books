import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repository.dart';

class FetchBookDetailsUseCase extends UseCase<BookEntity, String> {
  FetchBookDetailsUseCase({required HomeRepository homeRepository})
      : _repository = homeRepository;

  final HomeRepository _repository;

  @override
  Future<Either<AppFailure, BookEntity>> call([String? params]) async {
    assert(params != null);
    return _repository.fetchBookDetails(params!);
  }
}
