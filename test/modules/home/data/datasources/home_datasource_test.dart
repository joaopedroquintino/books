import 'package:books/core/api/errors/app_exception.dart';
import 'package:books/core/api/interface/http.dart';
import 'package:books/core/api/interface/http_response.dart';
import 'package:books/modules/home/data/datasources/home_datasource.dart';
import 'package:books/modules/home/domain/datasources/home_datasource.dart';
import 'package:books/packages/data/interface/data_return.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttp extends Mock implements Http {}

Future<void> main() async {
  late MockHttp _mockHttp;
  late HomeDataSource _datasource;

  setUp(() {
    _mockHttp = MockHttp();
    _datasource = HomeDataSourceImpl(http: _mockHttp);
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
}
