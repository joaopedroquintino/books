import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../../common/domain/entities/paginated_data_entity.dart';
import '../../../data/models/book_model.dart';
import '../../../domain/entities/book_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required UseCase<PaginatedDataEntity<BookEntity>, int?> fetchBooksUseCase,
  })  : _fetchBooksUseCase = fetchBooksUseCase,
        super(HomeInitialState());

  final UseCase<PaginatedDataEntity<BookEntity>, int?> _fetchBooksUseCase;

  PaginatedDataEntity<BookEntity>? books;

  Future<void> fetchBooks({bool reset = false}) async {
    if (state is HomeLoadingState) {
      return;
    }

    emit(HomeLoadingState());
    final int _page = (reset ? 0 : (books?.page ?? 0)) + 1;
    final result = await _fetchBooksUseCase(_page);

    result.fold(
      (error) =>
          emit(HomeErrorState(message: error.message ?? 'Erro desconhecido')),
      (paginatedData) {
        if (reset) {
          books = null;
        }
        books = paginatedData.copyWith(
          data: paginatedData.data..insertAll(0, books?.data ?? <BookModel>[]),
          page: paginatedData.page,
          totalItems: paginatedData.totalItems,
          totalPages: paginatedData.totalPages,
        );

        emit(HomeSuccessState());
      },
    );
  }
}
