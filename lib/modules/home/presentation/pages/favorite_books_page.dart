import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../../../../shared/loading/loading_widget.dart';
import '../../../../shared/logo/books_logo.dart';
import '../../../../ui/input/filled_text_field_widget.dart';
import '../../../login/login_routing.dart';
import '../cubits/favorite/favorite_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../widgets/books_list_widget.dart';

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({
    Key? key,
    required this.cubit,
    required this.favoriteCubit,
    required this.scrollController,
  }) : super(key: key);

  final HomeCubit cubit;
  final FavoriteCubit favoriteCubit;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppDS.spacing.small.w,
            AppDS.spacing.small.h,
            AppDS.spacing.small.w,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BooksLogo.horizontal(color: AppDS.color.black),
                  IconButton(
                    onPressed: () async {
                      cubit.logout();
                      Modular.to.navigate(
                        LoginRouteNamed.login.fullPath,
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppDS.spacing.xsmall.h,
                  bottom: AppDS.spacing.medium.h,
                ),
                child: Text.rich(
                  TextSpan(
                    style: AppDS.fonts.headline,
                    children: const [
                      TextSpan(text: 'Aqui estão os seus '),
                      TextSpan(
                        text: 'favoritos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              FilledTextFieldWidget(
                placeholder: 'Procure um livro',
                prefixIcon: const Icon(CupertinoIcons.search),
                onChanged: (text) {
                  favoriteCubit.filterBooks(text);
                },
              ),
              SizedBox(height: AppDS.spacing.xsmall.h),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder(
            bloc: favoriteCubit,
            builder: (context, state) {
              if (state is FavoriteSuccessState) {
                final _books = state.books;
                if (_books.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDS.spacing.huge.w,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      favoriteCubit.favoriteBooks.isEmpty
                          ? 'Ainda não há nada aqui. Comece favoritando um livro'
                          : 'Nenhum livro encontrado',
                      textAlign: TextAlign.center,
                      style: AppDS.fonts.headline,
                    ),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: BooksListWidget(
                        scrollController: scrollController,
                        books: _books,
                        onFavoriteBook: (book) async {
                          await cubit.favoriteBook(book);
                          favoriteCubit.fetchFavoriteBooks();
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is HomeErrorState) {
                return Center(child: Text(state.message));
              } else {
                return const Center(
                  child: AppLoadingWidget(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
