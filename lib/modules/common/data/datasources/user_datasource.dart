import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/local_storage/result_storage.dart';
import '../../../../packages/data/interface/data_return.dart';
import '../../domain/datasources/user_datasource.dart';
import '../models/user_model.dart';

const _userCollection = 'USER';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({
    required LocalStorage database,
  }) : _localStorage = database;

  final LocalStorage _localStorage;

  @override
  Future<DataReturn> getUser() async {
    try {
      final result = await _localStorage.findAll(_userCollection, '');
      if (result is SuccessData) {
        return DataSuccess(body: (result.data as List)[0]);
      } else {
        return DataError(message: result.message);
      }
    } catch (e) {
      return DataError(message: e.toString());
    }
  }

  @override
  Future<DataReturn> setUser(UserModel userModel) async {
    try {
      final result =
          await _localStorage.insert(_userCollection, userModel.toJson());
      if (result is SuccessData) {
        return DataSuccess(body: result.data);
      } else {
        return DataError(message: result.message);
      }
    } catch (e) {
      return DataError(message: e.toString());
    }
  }
}
