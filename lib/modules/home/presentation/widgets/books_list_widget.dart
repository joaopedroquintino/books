import '../../../../packages/ds/app_system.dart';
import '../../domain/entities/book_entity.dart';
import '../pages/book_details_page.dart';
import 'book_card.dart';

class BooksListWidget extends StatelessWidget {
  const BooksListWidget({
    Key? key,
    required this.scrollController,
    required this.books,
    this.onFavoriteBook,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<BookEntity> books;
  final void Function(BookEntity)? onFavoriteBook;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: scrollController,
        itemCount: books.length,
        padding: EdgeInsets.fromLTRB(
          AppDS.spacing.small.w,
          AppDS.spacing.small.h,
          AppDS.spacing.small.w,
          0,
        ),
        separatorBuilder: (_, __) {
          return SizedBox(
            height: AppDS.spacing.xsmall.h,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: BookCard(
              book: books[index],
              onFavorite: () => onFavoriteBook?.call(books[index]),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: AppDS.color.transparent,
                    context: context,
                    builder: (context) {
                      return BookDetailsPage(
                        id: books[index].id,
                      );
                    });
              },
            ),
          );
        });
  }
}
