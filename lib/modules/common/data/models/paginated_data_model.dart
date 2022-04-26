import '../../domain/entities/paginated_data_entity.dart';

class PaginatedDataModel<T> extends PaginatedDataEntity<T> {
  const PaginatedDataModel({
    required List<T> data,
    required int page,
    required int totalPages,
    required int totalItems,
  }) : super(
          data: data,
          page: page,
          totalItems: totalItems,
          totalPages: totalPages,
        );

  factory PaginatedDataModel.fromMap({
    required Map<String, dynamic> map,
    required T Function(Map<String, dynamic>) itemMapper,
  }) {
    return PaginatedDataModel<T>(
      data: (map['data'] as List)
          .map((x) => itemMapper(x as Map<String, dynamic>))
          .toList(),
      page: (map['page'] as num).toInt(),
      totalPages: (map['totalPages'] as num).toInt(),
      totalItems: (map['totalItems'] as num).toInt(),
    );
  }
}
