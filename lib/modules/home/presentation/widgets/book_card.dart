import '../../../../packages/ds/app_system.dart';
import '../../domain/entities/book_entity.dart';
import 'book_placeholder_widget.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
    this.onTap,
    this.onFavorite,
  }) : super(key: key);

  final BookEntity book;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppDS.color.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4.h),
              blurRadius: 24.h,
              spreadRadius: 0,
              color: AppDS.color.black.withOpacity(.09),
            ),
          ],
          borderRadius: BorderRadius.circular(AppDS.borderRadius.xxsmall.h),
        ),
        padding: EdgeInsets.fromLTRB(
          AppDS.spacing.small.w,
          AppDS.spacing.small.h,
          0,
          AppDS.spacing.small.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppDS.color.black.withOpacity(.15),
                    offset: Offset(0, 6.h),
                    blurRadius: 9.h,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Image.network(
                book.imageUrl ?? '',
                width: 81.w,
                errorBuilder: (context, _, __) {
                  return const BookPlaceholder();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDS.spacing.xsmall.w,
                  vertical: AppDS.spacing.xsmall.h,
                ).copyWith(right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: AppDS.fonts.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.authors.join(', '),
                          style: AppDS.fonts.body.copyWith(
                            color: AppDS.color.secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${book.pageCount} páginas',
                          style: AppDS.fonts.caption,
                        ),
                        Text(
                          book.publisher,
                          style: AppDS.fonts.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Publicado em ${book.published}',
                          style: AppDS.fonts.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTapUp: (_) {
                  onFavorite?.call();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppDS.spacing.xsmall.h,
                    right: AppDS.spacing.xsmall.w,
                  ),
                  child: book.favorite
                      ? Icon(
                          Icons.bookmark_rounded,
                          color: AppDS.color.secondary,
                        )
                      : const Icon(
                          Icons.bookmark_border_rounded,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
