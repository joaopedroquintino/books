import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repository.dart';

class FavoriteBookUseCase extends UseCase<Unit, BookEntity> {
  FavoriteBookUseCase({required HomeRepository homeRepository})
      : _repository = homeRepository;

  final HomeRepository _repository;

  @override
  Future<Either<AppFailure, Unit>> call([BookEntity? params]) async {
    return _repository.favoriteBook(params!);
  }
}
