import '../../../../packages/data/interface/data_return.dart';

abstract class HomeDataSource {
  Future<DataReturn> fetchBooks({int? page, String? search});
}
