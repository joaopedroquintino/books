import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required String id,
    required String title,
    required String description,
    required List<String> authors,
    required int pageCount,
    required String category,
    required String? imageUrl,
    required String isbn10,
    required String isbn13,
    required String language,
    required String publisher,
    required int published,
  }) : super(
            id: id,
            title: title,
            description: description,
            authors: authors,
            pageCount: pageCount,
            category: category,
            imageUrl: imageUrl,
            isbn10: isbn10,
            isbn13: isbn13,
            language: language,
            publisher: publisher,
            published: published);

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      authors: List<String>.from(map['authors'] as List),
      pageCount: (map['pageCount'] as num).toInt(),
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as String?,
      isbn10: map['isbn10'] as String,
      isbn13: map['isbn13'] as String,
      language: map['language'] as String,
      publisher: map['publisher'] as String,
      published: (map['published'] as num).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authors': authors,
      'pageCount': pageCount,
      'category': category,
      'imageUrl': imageUrl,
      'isbn10': isbn10,
      'isbn13': isbn13,
      'language': language,
      'publisher': publisher,
      'published': published,
    };
  }
}
