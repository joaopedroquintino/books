import 'package:books/core/api/errors/app_exception.dart';
import 'package:books/core/api/interface/http.dart';
import 'package:books/core/api/interface/http_response.dart';
import 'package:books/core/local_storage/local_storage.dart';
import 'package:books/core/local_storage/result_storage.dart';
import 'package:books/modules/home/data/datasources/home_datasource.dart';
import 'package:books/modules/home/data/models/book_model.dart';
import 'package:books/modules/home/domain/datasources/home_datasource.dart';
import 'package:books/packages/data/interface/data_return.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttp extends Mock implements Http {}

class MockDatabase extends Mock implements LocalStorage {}

Future<void> main() async {
  late MockHttp _mockHttp;
  late MockDatabase _mockDatabase;
  late HomeDataSource _datasource;

  setUp(() {
    _mockHttp = MockHttp();
    _mockDatabase = MockDatabase();
    _datasource = HomeDataSourceImpl(http: _mockHttp, database: _mockDatabase);
  });

  group('HomeDataSource fetchBooks', () {
    final dataSuccess = DataSuccess(body: {});
    const errorMessage = 'Infelizmente, algo deu errado.';

    test('should return DataSuccess when calling fetchBooks successfully',
        () async {
      when(
        () => _mockHttp.get<Map<String, dynamic>>(any()),
      ).thenAnswer(
          (invocation) async => HttpResponse<Map<String, dynamic>>(body: {}));

      final result = await _datasource.fetchBooks(page: 0);

      expect(result, isA<DataSuccess>());
      expect(result.body, dataSuccess.body);

      verify(() => _mockHttp.get<Map<String, dynamic>>(
          HomeDataSourceImpl.booksUrl(0, null))).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });

    test('should return DataError when failing fetchBooks', () async {
      when(
        () => _mockHttp.get<Map<String, dynamic>>(any()),
      ).thenThrow(AppException(message: errorMessage));

      final result = await _datasource.fetchBooks(page: 0);

      expect(result, isA<DataError>());
      expect(result.message, errorMessage);

      verify(() => _mockHttp.get<Map<String, dynamic>>(
          HomeDataSourceImpl.booksUrl(0, null))).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });
  });

  group('HomeDataSource fetchBookDetails', () {
    final dataSuccess = DataSuccess(body: {});
    const errorMessage = 'Infelizmente, algo deu errado.';
    const bookId = 'asd';

    test('should return DataSuccess when calling fetchBooks successfully',
        () async {
      when(
        () => _mockHttp.get<Map<String, dynamic>>(any()),
      ).thenAnswer(
          (invocation) async => HttpResponse<Map<String, dynamic>>(body: {}));

      final result = await _datasource.fetchBookDetails(bookId);

      expect(result, isA<DataSuccess>());
      expect(result.body, dataSuccess.body);

      verify(() => _mockHttp.get<Map<String, dynamic>>(
          HomeDataSourceImpl.bookDetailsUrl(bookId))).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });

    test('should return DataError when failing fetchBooks', () async {
      when(
        () => _mockHttp.get<Map<String, dynamic>>(any()),
      ).thenThrow(AppException(message: errorMessage));

      final result = await _datasource.fetchBookDetails(bookId);

      expect(result, isA<DataError>());
      expect(result.message, errorMessage);

      verify(() => _mockHttp.get<Map<String, dynamic>>(
          HomeDataSourceImpl.bookDetailsUrl(bookId))).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });
  });

  group('HomeDataSource favoriteBook', () {
    const tBook = BookModel(
        id: 'id',
        title: 'title',
        description: 'description',
        authors: ['authors'],
        pageCount: 200,
        category: 'category',
        imageUrl: 'imageUrl',
        isbn10: 'isbn10',
        isbn13: 'isbn13',
        language: 'language',
        publisher: 'publisher',
        published: 2022);
    const tCollectionName = 'favorite_books';

    test('should return true when calling favoriteBook successfully', () async {
      when(() => _mockDatabase.insert(any(), any()))
          .thenAnswer((invocation) async => SuccessData(data: true));

      final result = await _datasource.favoriteBook(tBook);

      expect(result, true);

      verify(() => _mockDatabase.insert(tCollectionName, tBook.toMap()))
          .called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });

    test('should return DataError when failing favoriteBook', () async {
      when(() => _mockDatabase.insert(any(), any()))
          .thenAnswer((_) async => ErrorData());

      final result = await _datasource.favoriteBook(tBook);

      expect(result, false);

      verify(() => _mockDatabase.insert(tCollectionName, tBook.toMap()))
          .called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });
  });

  group('HomeDataSource fetchFavoriteBooks', () {
    const tBook = BookModel(
        id: 'id',
        title: 'title',
        description: 'description',
        authors: ['authors'],
        pageCount: 200,
        category: 'category',
        imageUrl: 'imageUrl',
        isbn10: 'isbn10',
        isbn13: 'isbn13',
        language: 'language',
        publisher: 'publisher',
        published: 2022);

    final tMapList = [tBook.toMap()];
    const tCollectionName = 'favorite_books';

    test(
        'should return List of books when calling fetchFavoriteBooks successfully',
        () async {
      when(() => _mockDatabase.findAll(any(), any()))
          .thenAnswer((invocation) async => SuccessData(data: tMapList));

      final result = await _datasource.fetchFavoriteBooks();

      expect(result, tMapList);

      verify(() => _mockDatabase.findAll(tCollectionName, '')).called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });

    test('should return null when failing fetchFavoriteBooks', () async {
      when(() => _mockDatabase.findAll(any(), any()))
          .thenAnswer((_) async => ErrorData());

      final result = await _datasource.fetchFavoriteBooks();

      expect(result, null);

      verify(() => _mockDatabase.findAll(tCollectionName, '')).called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });
  });

  group('HomeDataSource removeBookFromFavorites', () {
    const tBook = BookModel(
        id: 'id',
        title: 'title',
        description: 'description',
        authors: ['authors'],
        pageCount: 200,
        category: 'category',
        imageUrl: 'imageUrl',
        isbn10: 'isbn10',
        isbn13: 'isbn13',
        language: 'language',
        publisher: 'publisher',
        published: 2022);
    const tCollectionName = 'favorite_books';

    test('should return true when calling removeBookFromFavorites successfully',
        () async {
      when(() => _mockDatabase.deleteFromKeyId(any(), any(), any()))
          .thenAnswer((invocation) async => SuccessData(data: true));

      final result = await _datasource.removeBookFromFavorites(tBook);

      expect(result, true);

      verify(() => _mockDatabase.deleteFromKeyId(
            tCollectionName,
            'book_id',
            tBook.id,
          )).called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });

    test('should return false when failing removeBookFromFavorites', () async {
      when(() => _mockDatabase.deleteFromKeyId(any(), any(), any()))
          .thenAnswer((_) async => ErrorData());

      final result = await _datasource.removeBookFromFavorites(tBook);

      expect(result, false);

      verify(() => _mockDatabase.deleteFromKeyId(
            tCollectionName,
            'book_id',
            tBook.id,
          )).called(1);
      verifyNoMoreInteractions(_mockDatabase);
    });
  });
}
