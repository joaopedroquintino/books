import '../../../../core/local_storage/local_storage.dart';
import '../../domain/datasources/authentication_datasource.dart';
import '../models/authentication_model.dart';

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  const AuthenticationDatasourceImpl({
    required LocalStorage localStorage,
    required LocalStorage secureLocalStorage,
  })  : _db = localStorage,
        _secureDb = secureLocalStorage;

  final LocalStorage _secureDb;
  final LocalStorage _db;

  static const String _collectionName = 'authentication';

  @override
  Future<AuthenticationModel?> getAuthentication() async {
    try {
      await _clearSecureStorageOnReinstall();
      final result = await _secureDb.findAll(_collectionName, '');
      final Map<String, dynamic> resultMap = result.data != null
          ? result.data as Map<String, dynamic>
          : <String, dynamic>{};
      if (resultMap.isNotEmpty) {
        return AuthenticationModel.fromJson(resultMap);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveAuthentication(AuthenticationModel dto) async {
    try {
      final result = await _secureDb.insert(
        _collectionName,
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
      final result = await _secureDb.clearCollection(_collectionName);
      return result.data as bool;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _clearSecureStorageOnReinstall() async {
    const String key = 'hasRunBefore';
    final result = await _db.findAll(key, key);

    if (result.data == null) {
      _secureDb.clearCollection(_collectionName);
      _db.insert(
        key,
        {
          key: true,
        },
      );
    }
  }
}
