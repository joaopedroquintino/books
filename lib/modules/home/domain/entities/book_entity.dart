import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  const BookEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.authors,
    required this.pageCount,
    required this.category,
    required this.imageUrl,
    required this.isbn10,
    required this.isbn13,
    required this.language,
    required this.publisher,
    required this.published,
  });
  final String id;
  final String title;
  final String description;
  final List<String> authors;
  final int pageCount;
  final String category;
  final String? imageUrl;
  final String isbn10;
  final String isbn13;
  final String language;
  final String publisher;
  final int published;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        authors,
        pageCount,
        category,
        imageUrl,
        isbn10,
        isbn13,
        language,
        publisher,
        published,
      ];
}
