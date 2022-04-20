import 'package:books/modules/common/data/models/paginated_data_model.dart';
import 'package:books/modules/home/data/models/book_model.dart';
import 'package:books/modules/home/data/repositories/home_repository.dart';
import 'package:books/modules/home/domain/datasources/home_datasource.dart';
import 'package:books/modules/home/domain/repositories/home_repository.dart';
import 'package:books/packages/data/interface/data_return.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDataSource extends Mock implements HomeDataSource {}

Future<void> main() async {
  late MockDataSource _mockDataSource;
  late HomeRepository _repository;

  setUp(() {
    _mockDataSource = MockDataSource();
    _repository = HomeRepositoryImpl(homeDataSource: _mockDataSource);
  });

  group('HomeRepository fetchBooks', () {
    const errorMessage = 'Infelizmente, algo deu errado.';
    final dataSuccess = DataSuccess(body: _booksReturn);
    final dataError = DataError(message: errorMessage);
    final paginatedBooksModel = PaginatedDataModel.fromMap(
        map: _booksReturn, itemMapper: BookModel.fromMap);

    test(
        'should return Right<PaginatedDataModel<BookModel>> when calling fetchBooks successfully',
        () async {
      when(
        () => _mockDataSource.fetchBooks(page: 0, search: null),
      ).thenAnswer((invocation) async => dataSuccess);

      final result = await _repository.fetchBooks(page: 0);

      expect(result, Right(paginatedBooksModel));

      verify(() => _mockDataSource.fetchBooks(page: 0, search: null)).called(1);
      verifyNoMoreInteractions(_mockDataSource);
    });

    test('should return Left<AppFailure> on fail fetchBooks', () async {
      when(
        () => _mockDataSource.fetchBooks(page: 0, search: null),
      ).thenAnswer((invocation) async => dataError);

      final result = await _repository.fetchBooks(page: 0);

      expect(result, const Left(AppFailure(message: errorMessage)));

      verify(() => _mockDataSource.fetchBooks(page: 0, search: null)).called(1);
      verifyNoMoreInteractions(_mockDataSource);
    });

    test(
        'should return Left<AppFailure> on fail decoding answer from fetchBooks',
        () async {
      when(
        () => _mockDataSource.fetchBooks(page: 0, search: null),
      ).thenAnswer((invocation) async => DataSuccess(body: {'data': []}));

      final result = await _repository.fetchBooks(page: 0);

      expect(
        result,
        const Left(
          AppFailure(message: 'HomeRepository fetchBooks decode error'),
        ),
      );

      verify(() => _mockDataSource.fetchBooks(page: 0, search: null)).called(1);
      verifyNoMoreInteractions(_mockDataSource);
    });
  });
}

final _booksReturn = {
  'data': [
    {
      'id': '8f41b92c7460b9337660427e',
      'title': 'A Culpa é das Estrelas',
      'description':
          'Hazel foi diagnosticada com câncer aos treze anos e agora, aos dezesseis, sobrevive graças a uma droga revolucionária que detém a metástase em seus pulmões. Ela sabe que sua doença é terminal e passa os dias vendo tevê e lendo Uma aflição imperial, livro cujo autor deixou muitas perguntas sem resposta. ',
      'authors': ['Jonh Green'],
      'pageCount': 288,
      'category': 'Romance',
      'imageUrl': 'https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg',
      'isbn10': '0062856626',
      'isbn13': '978-0062856623',
      'language': 'Inglês',
      'publisher': 'Intrínseca',
      'published': 2002
    }
  ],
  'page': 1,
  'totalPages': 34,
  'totalItems': 674
};
