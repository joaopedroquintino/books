part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  const FavoriteErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class FavoriteSuccessState extends FavoriteState {
  const FavoriteSuccessState({required this.books});

  final List<BookEntity> books;

  @override
  List<Object> get props => [books];
}
