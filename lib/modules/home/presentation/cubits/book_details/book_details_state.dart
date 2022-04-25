part of 'book_details_cubit.dart';

abstract class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object> get props => [];
}

class BookDetailsInitialState extends BookDetailsState {}

class BookDetailsLoadingState extends BookDetailsState {}

class BookDetailsSuccessState extends BookDetailsState {
  const BookDetailsSuccessState({required this.book});

  final BookEntity book;

  @override
  List<Object> get props => [book];
}

class BookDetailsErrorState extends BookDetailsState {
  const BookDetailsErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
