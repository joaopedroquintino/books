import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../../../../shared/loading/loading_widget.dart';
import '../../../../shared/logo/books_logo.dart';
import '../../../../ui/input/filled_text_field_widget.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/user/user_cubit.dart';
import '../widgets/book_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeCubit> {
  final scrollController = ScrollController();
  late UserCubit userCubit;

  @override
  void initState() {
    cubit.fetchBooks();
    userCubit = Modular.get<UserCubit>()..fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: Column(
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
                        const Icon(Icons.logout),
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
                      placeholder: 'Buscar livro',
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
                    if (controller.books != null) {
                      final _books = controller.books!.data;
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
                                child: ListView.separated(
                                    controller: scrollController,
                                    itemCount: _books.length,
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
                                        height: 160.h,
                                        width: double.infinity,
                                        child: BookCard(book: _books[index]),
                                      );
                                    }),
                              ),
                              if (state is HomeLoadingState)
                                const AppLoadingWidget(),
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
          ),
        ),
      ),
    );
  }
}
