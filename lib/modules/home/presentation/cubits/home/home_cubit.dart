import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
    required UseCase<Unit, BookEntity> favoriteBookUseCase,
    required UseCase<List<BookEntity>, dynamic> fetchFavoriteBooksUseCase,
  })  : _fetchBooksUseCase = fetchBooksUseCase,
        _removeAuthenticationUseCase = removeAuthenticationUseCase,
        _favoriteBookUseCase = favoriteBookUseCase,
        _fetchFavoriteBooksUseCase = fetchFavoriteBooksUseCase,
        super(HomeInitialState());

  final UseCase<PaginatedDataEntity<BookEntity>, FetchBooksParams?>
      _fetchBooksUseCase;
  final UseCase<bool, dynamic> _removeAuthenticationUseCase;
  final UseCase<Unit, BookEntity> _favoriteBookUseCase;
  final UseCase<List<BookEntity>, dynamic> _fetchFavoriteBooksUseCase;

  PaginatedDataEntity<BookEntity>? books;
  String? titleSearch;

  Timer? _debounce;
  List<BookEntity>? favoriteBooks;

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
    if (_reset) {
      books = null;
    }

    emit(HomeLoadingState());

    final int _page = (_reset ? 0 : (books?.page ?? 0)) + 1;
    final result = await _fetchBooksUseCase(
        FetchBooksParams(page: _page, search: titleSearch));

    await result.fold<Future>(
      (error) async =>
          emit(HomeErrorState(message: error.message ?? 'Erro desconhecido')),
      (paginatedData) async {
        if (_reset) {
          books = null;
        }
        books = paginatedData.copyWith(
          data: paginatedData.data..insertAll(0, books?.data ?? <BookModel>[]),
          page: paginatedData.page,
          totalItems: paginatedData.totalItems,
          totalPages: paginatedData.totalPages,
        );
        await _updateFavorites();
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

  Future<void> favoriteBook(BookEntity book) async {
    final result = await _favoriteBookUseCase(book);

    result.fold(
      (l) => null,
      (r) {
        emit(HomeInitialState());
        // final bookIndex = books!.data.indexWhere((e) => e.id == book.id);
        // final _newBooks = books?.data
        //   ?..replaceRange(bookIndex, bookIndex + 1, <BookModel>[
        //     (book as BookModel).copyWith(favorite: !book.favorite)
        //   ]);
        // books = books?.copyWith(data: _newBooks);
        _updateFavorites();
        emit(HomeSuccessState());
      },
    );
  }

  Future<void> _updateFavorites() async {
    final resultFavorites = await _fetchFavoriteBooksUseCase();
    resultFavorites.fold(
      (l) => null,
      (r) {
        favoriteBooks = r;
        books = books?.copyWith(
          data: books?.data.map((e) {
            return (e as BookModel).copyWith(
              favorite: favoriteBooks?.any((element) => element.id == e.id),
            );
          }).toList(),
        );
      },
    );
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
