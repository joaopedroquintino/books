import 'package:sembast/sembast.dart';

import 'local_storage.dart';
import 'result_storage.dart';
import 'sembest_storage.dart';

class LocalStorageImpDao implements LocalStorage {
  Future<Database> get _db async => SembestStorage.instance.database;

  @override
  Future<ResultStorage> clearCollection(
    String collectionName,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final int _result = await _store.delete(await _db);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> insert(
    String collectionName,
    Map<String, dynamic> value,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final int _result = await _store.add(await _db, value);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> delete(
    String collectionName,
    String key,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final Finder finder = Finder(filter: Filter.byKey(int.parse(key)));

      final int _result = await _store.delete(await _db, finder: finder);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> findAllFilter(
    String collectionName,
    String filterField,
    String filterValue,
    String sortField,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final Finder finder = Finder(
        filter: Filter.equals(filterField, filterValue),
        sortOrders: <SortOrder>[
          SortOrder(sortField),
        ],
      );

      final List<RecordSnapshot<int, Map<String, Object?>>> recordSnapshot =
          await _store.find(await _db, finder: finder);

      final List<Map<String, dynamic>> dataResult = recordSnapshot
          .map(
            (RecordSnapshot<int, Map<String, Object?>> snapshot) =>
                Map<String, dynamic>.from(snapshot.value)
                  ..addAll(
                    <String, String>{'id': snapshot.key.toString()},
                  ),
          )
          .toList();

      return SuccessData(data: dataResult);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> findAll(
    String collectionName,
    String sortField,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final Finder finder = Finder(
        sortOrders: <SortOrder>[
          SortOrder(sortField),
        ],
      );

      final List<RecordSnapshot<int, Map<String, Object?>>> recordSnapshot =
          await _store.find(await _db, finder: finder);

      final List<Map<String, dynamic>> dataResult = recordSnapshot
          .map(
            (RecordSnapshot<int, Map<String, Object?>> snapshot) =>
                Map<String, dynamic>.from(snapshot.value)
                  ..addAll(
                    <String, String>{'id': snapshot.key.toString()},
                  ),
          )
          .toList();

      return SuccessData(data: dataResult);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }

  @override
  Future<ResultStorage> deleteFromKeyId(
    String collectionName,
    String key,
    String value,
  ) async {
    try {
      final StoreRef<int, Map<String, Object?>> _store =
          intMapStoreFactory.store(collectionName);

      final Finder finder = Finder(
        filter: Filter.equals(key, value),
      );

      final int _result = await _store.delete(await _db, finder: finder);

      return SuccessData(data: _result);
    } on Exception catch (_) {
      return ErrorData(
        errorMessage: '',
        data: null,
      );
    }
  }
}
