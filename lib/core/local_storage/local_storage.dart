import 'result_storage.dart';

abstract class LocalStorage {
  Future<ResultStorage> clearCollection(
    String collectionName,
  );
  Future<ResultStorage> insert(
    String collectionName,
    Map<String, dynamic> value,
  );
  Future<ResultStorage> delete(
    String collectionName,
    String key,
  );
  Future<ResultStorage> deleteFromKeyId(
    String collectionName,
    String key,
    String value,
  );
  Future<ResultStorage> findAll(
    String collectionName,
    String sortField,
  );
  Future<ResultStorage> findAllFilter(
    String collectionName,
    String filterField,
    String filterValue,
    String sortField,
  );
}
