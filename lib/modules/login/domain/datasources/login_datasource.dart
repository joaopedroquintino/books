import '../../../../packages/data/interface/data_return.dart';
import '../../data/dto/login_dto.dart';

abstract class LoginDatasource {
  Future<DataReturn> authenticate(LoginDTO dto);
}
