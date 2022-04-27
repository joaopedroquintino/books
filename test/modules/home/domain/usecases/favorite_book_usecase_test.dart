import 'package:books/modules/home/domain/entities/book_entity.dart';
import 'package:books/modules/home/domain/repositories/home_repository.dart';
import 'package:books/modules/home/domain/usecases/favorite_book_usecase.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class FakeBookEntity extends Fake implements BookEntity {}

Future<void> main() async {
  late MockHomeRepository _mockRepository;
  late FavoriteBookUseCase _usecase;

  setUp(() {
    _mockRepository = MockHomeRepository();
    _usecase = FavoriteBookUseCase(
      homeRepository: _mockRepository,
    );
    registerFallbackValue(FakeBookEntity());
  });

  group('FavoriteBookUseCase', () {
    const tBook = BookEntity(
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
    const tFavoriteBook = BookEntity(
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
      favorite: true,
    );

    const tError = AppFailure(message: 'Erro');

    test(
      'should return an Unit when favorite book with success',
      () async {
        when(() => _mockRepository.favoriteBook(any())).thenAnswer(
          (_) async => const Right(unit),
        );

        final result = await _usecase(tBook);

        expect(result, const Right(unit));
        verify(() => _mockRepository.favoriteBook(tFavoriteBook)).called(1);
        verifyNever(() => _mockRepository.removeBookFromFavorites(any()));
        verifyNoMoreInteractions(_mockRepository);
      },
    );

    test(
      'should return an Unit when removing a book from favorites with success',
      () async {
        when(() => _mockRepository.removeBookFromFavorites(any())).thenAnswer(
          (_) async => const Right(unit),
        );

        final result = await _usecase(tFavoriteBook);

        expect(result, const Right(unit));
        verify(() => _mockRepository.removeBookFromFavorites(tBook)).called(1);
        verifyNever(() => _mockRepository.favoriteBook(any()));
        verifyNoMoreInteractions(_mockRepository);
      },
    );

    test('should return an AppFailure when favorite book returns error',
        () async {
      when(() => _mockRepository.favoriteBook(any())).thenAnswer(
        (_) async => const Left(tError),
      );

      final result = await _usecase(tBook);

      expect(result, const Left(tError));
      verify(() => _mockRepository.favoriteBook(tFavoriteBook)).called(1);
      verifyNever(() => _mockRepository.removeBookFromFavorites(any()));
      verifyNoMoreInteractions(_mockRepository);
    });

    test(
        'should return an AppFailure when removing a book from favorites returns error',
        () async {
      when(() => _mockRepository.removeBookFromFavorites(any())).thenAnswer(
        (_) async => const Left(tError),
      );

      final result = await _usecase(tFavoriteBook);

      expect(result, const Left(tError));
      verifyNever(() => _mockRepository.favoriteBook(any()));
      verify(() => _mockRepository.removeBookFromFavorites(tBook)).called(1);
      verifyNoMoreInteractions(_mockRepository);
    });
  });
}
