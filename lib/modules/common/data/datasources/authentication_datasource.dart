import '../../../../core/api/errors/app_exception.dart';
import '../../../../core/api/interface/http.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../../../packages/data/interface/data_return.dart';
import '../../../login/data/dto/authentication_dto.dart';
import '../../domain/datasources/authentication_datasource.dart';

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  AuthenticationDatasourceImpl({
    required LocalStorage localStorage,
    required LocalStorage secureLocalStorage,
  })  : _db = localStorage,
        _secureDb = secureLocalStorage;

  final LocalStorage _secureDb;
  final LocalStorage _db;
  String collectionName = 'authentication';

  static const String refreshTokenUrl = '/auth/refresh-token';

  @override
  Future<AuthenticationDTO?> getAuthentication() async {
    try {
      await _clearSecureStorageOnReinstall();
      final result = await _secureDb.findAll(collectionName, '');
      final Map<String, dynamic> resultMap = result.data != null
          ? result.data as Map<String, dynamic>
          : <String, dynamic>{};
      if (resultMap.isNotEmpty) {
        return AuthenticationDTO.fromJson(resultMap);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveAuthentication(AuthenticationDTO dto) async {
    try {
      final result = await _secureDb.insert(
        collectionName,
        dto.toJson(),
      );
      return result.data as bool;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteAuthentication() async {
    try {
      final result = await _secureDb.clearCollection(collectionName);
      return result.data as bool;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _clearSecureStorageOnReinstall() async {
    const String key = 'hasRunBefore';
    final result = await _db.findAll(key, key);

    if (result.data == null) {
      _secureDb.clearCollection(collectionName);
      _db.insert(
        key,
        {
          key: true,
        },
      );
    }
  }

  @override
  Future<DataReturn> refreshToken() async {
    return DataSuccess(body: {});
  }
}
