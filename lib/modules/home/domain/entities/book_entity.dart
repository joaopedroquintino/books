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
    required this.favorite,
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
  final bool favorite;

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
        favorite,
      ];

  BookEntity copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? authors,
    int? pageCount,
    String? category,
    String? imageUrl,
    String? isbn10,
    String? isbn13,
    String? language,
    String? publisher,
    int? published,
    bool? favorite,
  }) {
    return BookEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      authors: authors ?? this.authors,
      pageCount: pageCount ?? this.pageCount,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isbn10: isbn10 ?? this.isbn10,
      isbn13: isbn13 ?? this.isbn13,
      language: language ?? this.language,
      publisher: publisher ?? this.publisher,
      published: published ?? this.published,
      favorite: favorite ?? this.favorite,
    );
  }
}
