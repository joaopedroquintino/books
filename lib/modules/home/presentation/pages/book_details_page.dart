import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../cubits/book_details/book_details_cubit.dart';
import '../widgets/book_placeholder_widget.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState
    extends ModularState<BookDetailsPage, BookDetailsCubit> {
  @override
  void initState() {
    cubit.fetchBook(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDS.color.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDS.borderRadius.normal.h),
          ),
          child: Container(
            height: .9.sh,
            color: AppDS.color.background,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDS.spacing.small.h),
                        child: Text(
                          'Detalhes',
                          textAlign: TextAlign.center,
                          style: AppDS.fonts.bodyLarge,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: Modular.to.pop,
                        icon: Icon(
                          Icons.close,
                          color: AppDS.color.secondary,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: BlocBuilder(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is BookDetailsSuccessState) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDS.spacing.small.w,
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: AppDS.spacing.medium.h),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppDS.color.black
                                                .withOpacity(.15),
                                            offset: Offset(0, 6.h),
                                            blurRadius: 9.h,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        state.book.imageUrl ?? '',
                                        width: 168.w,
                                        errorBuilder: (context, _, __) {
                                          return BookPlaceholder(
                                            width: 168.w,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.book.title,
                                    textAlign: TextAlign.start,
                                    style: AppDS.fonts.title2.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    state.book.authors.join(','),
                                    textAlign: TextAlign.start,
                                    style: AppDS.fonts.body.copyWith(
                                      color: AppDS.color.secondary,
                                    ),
                                  ),
                                  SizedBox(height: AppDS.spacing.medium.h),
                                  Text(
                                    'INFORMAÇÕES',
                                    style: AppDS.fonts.body.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppDS.color.contrast,
                                    ),
                                  ),
                                  SizedBox(height: AppDS.spacing.xsmall.h),
                                  buildBookInfo('Páginas',
                                      '${state.book.pageCount} páginas'),
                                  buildBookInfo(
                                      'Editora', state.book.publisher),
                                  buildBookInfo('Publicação',
                                      state.book.published.toString()),
                                  buildBookInfo('Idioma', state.book.language),
                                  buildBookInfo(
                                      'Título Original', state.book.title),
                                  buildBookInfo('ISBN-10', state.book.isbn10),
                                  buildBookInfo('ISBN-13', state.book.isbn13),
                                  SizedBox(height: AppDS.spacing.medium.h),
                                  Text(
                                    'RESENHA DA EDITORA',
                                    style: AppDS.fonts.body.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppDS.color.contrast,
                                    ),
                                  ),
                                  SizedBox(height: AppDS.spacing.xsmall.h),
                                  Text(
                                    state.book.description,
                                    style: AppDS.fonts.body.copyWith(
                                      color: AppDS.color.gray,
                                    ),
                                  ),
                                  SizedBox(height: AppDS.spacing.medium.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is BookDetailsErrorState) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBookInfo(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppDS.fonts.body.copyWith(
            fontWeight: FontWeight.w500,
            color: AppDS.color.contrast,
          ),
        ),
        Text(
          info,
          style: AppDS.fonts.body.copyWith(
            color: AppDS.color.gray,
          ),
        ),
      ],
    );
  }
}
