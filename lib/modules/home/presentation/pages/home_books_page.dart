import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../../../../shared/loading/loading_widget.dart';
import '../../../../shared/logo/books_logo.dart';
import '../../../../ui/input/filled_text_field_widget.dart';
import '../../../login/login_routing.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/user/user_cubit.dart';
import '../widgets/books_list_widget.dart';

class HomeBooksPage extends StatelessWidget {
  const HomeBooksPage({
    Key? key,
    required this.cubit,
    required this.userCubit,
    required this.scrollController,
  }) : super(key: key);

  final HomeCubit cubit;
  final UserCubit userCubit;
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
                child: BlocBuilder(
                  bloc: userCubit,
                  builder: (context, state) {
                    if (state is UserSuccessState) {
                      return Text.rich(
                        TextSpan(
                          style: AppDS.fonts.headline,
                          children: [
                            const TextSpan(text: 'Bem-vindo(a), '),
                            TextSpan(
                              text: '${state.user.name}!',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      );
                    } else if (state is UserLoadingState) {
                      return const Text('Loading user...');
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              FilledTextFieldWidget(
                placeholder: 'Procure um livro',
                prefixIcon: const Icon(CupertinoIcons.search),
                onChanged: (text) {
                  cubit.searchBooks(text);
                },
              ),
              SizedBox(height: AppDS.spacing.xsmall.h),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder(
            bloc: cubit,
            builder: (context, HomeState state) {
              if (cubit.books != null) {
                final _books = cubit.books!.data;

                if (state is HomeSuccessState && _books.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDS.spacing.huge.w,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Nenhum livro encontrado',
                      textAlign: TextAlign.center,
                      style: AppDS.fonts.headline,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    cubit.fetchBooks(reset: true);
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (scrollController.offset ==
                          scrollController.position.maxScrollExtent) {
                        cubit.fetchBooks();
                      }
                      return false;
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: BooksListWidget(
                            scrollController: scrollController,
                            books: _books,
                            onFavoriteBook: cubit.favoriteBook,
                          ),
                        ),
                        if (state is HomeLoadingState) const AppLoadingWidget(),
                        if (state is HomeErrorState) Text(state.message),
                      ],
                    ),
                  ),
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
