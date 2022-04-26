import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../domain/entities/book_entity.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit({
    required UseCase<BookEntity, String> fetchBookDetailsUseCase,
  })  : _fetchBookDetailsUseCase = fetchBookDetailsUseCase,
        super(BookDetailsLoadingState());

  final UseCase<BookEntity, String> _fetchBookDetailsUseCase;

  Future<void> fetchBook(String id) async {
    emit(BookDetailsLoadingState());
    final result = await _fetchBookDetailsUseCase(id);

    result.fold(
      (error) => emit(
          BookDetailsErrorState(message: error.message ?? 'Erro desconhecido')),
      (bookEntity) => emit(BookDetailsSuccessState(book: bookEntity)),
    );
  }
}
