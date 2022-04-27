import 'package:books/modules/home/domain/entities/book_entity.dart';
import 'package:books/modules/home/domain/repositories/home_repository.dart';
import 'package:books/modules/home/domain/usecases/fetch_favorite_books_usecase.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

Future<void> main() async {
  late MockHomeRepository _mockRepository;
  late FetchFavoriteBooksUseCase _usecase;

  setUp(() {
    _mockRepository = MockHomeRepository();
    _usecase = FetchFavoriteBooksUseCase(
      homeRepository: _mockRepository,
    );
  });

  group('FetchFavoriteBooksUseCase', () {
    const tBookEntity = BookEntity(
      id: 'id',
      title: 'title',
      description: 'description',
      authors: ['authors'],
      pageCount: 1,
      category: 'category',
      imageUrl: 'imageUrl',
      isbn10: 'isbn10',
      isbn13: 'isbn13',
      language: 'language',
      publisher: 'publisher',
      published: 2020,
      favorite: false,
    );

    final tBooksList = [tBookEntity];

    const tError = AppFailure(message: 'Erro');
    test(
      'should return an PaginatedDataEntity<BookEntity> when fetch books with success',
      () async {
        when(() => _mockRepository.fetchFavoriteBooks()).thenAnswer(
          (_) async => Right(tBooksList),
        );

        final result = await _usecase();

        expect(result, Right(tBooksList));
        verify(() => _mockRepository.fetchFavoriteBooks()).called(1);
        verifyNoMoreInteractions(_mockRepository);
      },
    );

    test('should return an AppFailure when fetch books returns error',
        () async {
      when(() => _mockRepository.fetchFavoriteBooks()).thenAnswer(
        (_) async => const Left(tError),
      );

      final result = await _usecase();

      expect(result, const Left(tError));
      verify(() => _mockRepository.fetchFavoriteBooks()).called(1);
      verifyNoMoreInteractions(_mockRepository);
    });
  });
}
