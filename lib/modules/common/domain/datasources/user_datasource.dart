import '../../../../packages/data/interface/data_return.dart';
import '../../data/models/user_model.dart';

abstract class UserDataSource {
  Future<DataReturn> getUser();
  Future<DataReturn> setUser(UserModel userEntity);
}
