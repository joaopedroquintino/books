import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../domain/entities/book_entity.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required UseCase<List<BookEntity>, dynamic> fetchFavoriteBooksUseCase,
    required UseCase<Unit, BookEntity> favoriteBookUseCase,
  })  : _fetchFavoriteBooksUseCase = fetchFavoriteBooksUseCase,
        _favoriteBookUseCase = favoriteBookUseCase,
        super(FavoriteInitialState());

  final UseCase<List<BookEntity>, dynamic> _fetchFavoriteBooksUseCase;
  final UseCase<Unit, BookEntity> _favoriteBookUseCase;

  List<BookEntity> favoriteBooks = [];

  Future<void> fetchFavoriteBooks() async {
    emit(FavoriteLoadingState());
    final resultFavorites = await _fetchFavoriteBooksUseCase();
    resultFavorites.fold(
      (l) => emit(
        const FavoriteErrorState(
            message: 'Houve um erro ao buscar os seus livros favoritos.'),
      ),
      (r) {
        favoriteBooks = r;
        emit(FavoriteSuccessState(books: r));
      },
    );
  }

  Future<void> favoriteBook(BookEntity book) async {
    final result = await _favoriteBookUseCase(book);

    await result.fold(
      (l) => null,
      (r) async {
        await fetchFavoriteBooks();
      },
    );
  }

  Future<void> filterBooks(String text) async {
    if (state is! FavoriteSuccessState) {
      return;
    }
    if (text.isEmpty) {
      emit(FavoriteSuccessState(books: favoriteBooks));
      return;
    }
    emit(FavoriteLoadingState());
    final books = favoriteBooks
        .where((element) => element.title.toLowerCase().contains(
              text.toLowerCase(),
            ))
        .toList();
    emit(FavoriteSuccessState(books: books));
  }
}
