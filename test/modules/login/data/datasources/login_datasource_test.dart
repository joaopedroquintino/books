import 'package:books/core/api/errors/app_exception.dart';
import 'package:books/core/api/interface/http.dart';
import 'package:books/core/api/interface/http_response.dart';
import 'package:books/modules/login/data/datasources/login_datasource.dart';
import 'package:books/modules/login/data/dto/login_dto.dart';
import 'package:books/modules/login/domain/datasources/login_datasource.dart';
import 'package:books/packages/data/interface/data_return.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttp extends Mock implements Http {}

Future<void> main() async {
  late MockHttp _mockHttp;
  late LoginDatasource _datasource;

  setUp(() {
    _mockHttp = MockHttp();
    _datasource = LoginDatasourceImpl(http: _mockHttp);
  });

  group('LoginDatasource fetchBooks', () {
    final dataSuccess = DataSuccess(body: {});
    const errorMessage = 'Infelizmente, algo deu errado.';
    const tLoginDTO = LoginDTO(password: 'pass', username: 'username');

    test('should return DataSuccess when authenticated successfully', () async {
      when(
        () => _mockHttp.post<Map<String, dynamic>>(any(), any()),
      ).thenAnswer(
          (invocation) async => HttpResponse<Map<String, dynamic>>(body: {}));

      final result = await _datasource.authenticate(tLoginDTO);

      expect(result, isA<DataSuccess>());
      expect(result.body, dataSuccess.body);

      verify(
        () => _mockHttp.post<Map<String, dynamic>>(
          LoginDatasourceImpl.url,
          tLoginDTO.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });

    test('should return DataError when failing fetchBooks', () async {
      when(
        () => _mockHttp.post<Map<String, dynamic>>(any(), any()),
      ).thenThrow(AppException(message: errorMessage));

      final result = await _datasource.authenticate(tLoginDTO);

      expect(result, isA<DataError>());
      expect(result.message, errorMessage);

      verify(
        () => _mockHttp.post<Map<String, dynamic>>(
          LoginDatasourceImpl.url,
          tLoginDTO.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(_mockHttp);
    });
  });
}
