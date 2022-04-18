import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage.dart';
import 'result_storage.dart';

class SecureStorageImp implements LocalStorage {
  static const FlutterSecureStorage _db = FlutterSecureStorage();

  @override
  Future<ResultStorage> clearCollection(String _) async {
    try {
      await _db.deleteAll();
      return SuccessData(data: true);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> delete(String _, String key) async {
    try {
      await _db.delete(key: key);
      return SuccessData(data: true);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> deleteFromKeyId(
    String _,
    String key,
    String value,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<ResultStorage> findAll(String collection, String _) async {
    try {
      final String? result = await _db.read(key: collection);
      return SuccessData(
        data: result != null ? jsonDecode(result) : null,
      );
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> findAllFilter(
    String _,
    String filterField,
    String filterValue,
    String sortField,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<ResultStorage> insert(
    String collection,
    Map<String, dynamic> map,
  ) async {
    try {
      await _db.write(
        key: collection,
        value: jsonEncode(map),
      );
      return SuccessData(data: true);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }
}
