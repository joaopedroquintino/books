import 'package:equatable/equatable.dart';

class PaginatedDataEntity<T> extends Equatable {
  const PaginatedDataEntity({
    required this.data,
    required this.page,
    required this.totalPages,
    required this.totalItems,
  });

  final List<T> data;
  final int page;
  final int totalPages;
  final int totalItems;

  bool get isLastPage => page >= totalPages;

  PaginatedDataEntity<T> copyWith({
    List<T>? data,
    int? page,
    int? totalPages,
    int? totalItems,
  }) {
    return PaginatedDataEntity<T>(
      data: data ?? this.data,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  @override
  List<Object?> get props => [
        data,
        page,
        totalPages,
        totalItems,
      ];
}
