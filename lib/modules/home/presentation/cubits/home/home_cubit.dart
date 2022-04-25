import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../../../packages/ds/app_system.dart';
import '../../../../common/domain/entities/paginated_data_entity.dart';
import '../../../data/models/book_model.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/usecases/fetch_books_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required UseCase<PaginatedDataEntity<BookEntity>, FetchBooksParams?>
        fetchBooksUseCase,
    required UseCase<bool, dynamic> removeAuthenticationUseCase,
  })  : _fetchBooksUseCase = fetchBooksUseCase,
        _removeAuthenticationUseCase = removeAuthenticationUseCase,
        super(HomeInitialState());

  final UseCase<PaginatedDataEntity<BookEntity>, FetchBooksParams?>
      _fetchBooksUseCase;
  final UseCase<bool, dynamic> _removeAuthenticationUseCase;

  PaginatedDataEntity<BookEntity>? books;
  String? titleSearch;

  Timer? _debounce;

  Future<void> fetchBooks({bool reset = false, String? title}) async {
    bool _reset = reset;
    if (titleSearch != (title ?? titleSearch)) {
      _reset = true;
      books = null;
      titleSearch = title;
    }
    if (state is HomeLoadingState && title == null) {
      return;
    }

    emit(HomeLoadingState());
    final int _page = (_reset ? 0 : (books?.page ?? 0)) + 1;
    final result = await _fetchBooksUseCase(
        FetchBooksParams(page: _page, search: titleSearch));

    result.fold(
      (error) =>
          emit(HomeErrorState(message: error.message ?? 'Erro desconhecido')),
      (paginatedData) {
        if (_reset) {
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

  void searchBooks(String title) {
    _initDebounce(callback: () {
      if (title.isEmpty && titleSearch != title) {
        fetchBooks(reset: true);
      }
      if (title.length < 3 || titleSearch == title) {
        return;
      }

      fetchBooks(title: title);
    });
  }

  void logout() {
    _removeAuthenticationUseCase();
  }

  void _initDebounce({required VoidCallback callback}) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(
      const Duration(seconds: 1),
      callback,
    );
  }
}
