import 'package:books/modules/home/domain/entities/book_entity.dart';
import 'package:books/modules/home/domain/repositories/home_repository.dart';
import 'package:books/modules/home/domain/usecases/fetch_book_details_usecase.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

Future<void> main() async {
  late MockHomeRepository _mockRepository;
  late FetchBookDetailsUseCase _usecase;

  setUp(() {
    _mockRepository = MockHomeRepository();
    _usecase = FetchBookDetailsUseCase(
      homeRepository: _mockRepository,
    );
  });

  group('FetchBookDetailsUseCase', () {
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
    const tError = AppFailure(message: 'Erro');
    const bookId = 'asdads';

    test(
      'should return a BookEntity when fetch details with success',
      () async {
        when(() => _mockRepository.fetchBookDetails(any())).thenAnswer(
          (_) async => const Right(tBookEntity),
        );

        final result = await _usecase(bookId);

        expect(result, const Right(tBookEntity));
        verify(() => _mockRepository.fetchBookDetails(bookId)).called(1);

        verifyNoMoreInteractions(_mockRepository);
      },
    );

    test('should return an AppFailure when fetch details returns error',
        () async {
      when(() => _mockRepository.fetchBookDetails(any())).thenAnswer(
        (_) async => const Left(tError),
      );

      final result = await _usecase(bookId);

      expect(result, const Left(tError));
      verify(() => _mockRepository.fetchBookDetails(bookId)).called(1);

      verifyNoMoreInteractions(_mockRepository);
    });
  });
}
