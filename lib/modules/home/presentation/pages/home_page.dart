import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../../../../shared/loading/loading_widget.dart';
import '../../../../shared/logo/books_logo.dart';
import '../../../../ui/input/text_field_widget.dart';
import '../cubit/home_cubit.dart';
import '../widgets/book_card.dart';
import '../widgets/book_placeholder_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeCubit> {
  final scrollController = ScrollController();

  @override
  void initState() {
    cubit.fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BooksLogo.horizontal(color: AppDS.color.black),
                      const Icon(Icons.logout),
                    ],
                  ),
                  SizedBox(height: AppDS.spacing.small.h),
                  const TextFieldWidget(
                    placeholder: 'Buscar',
                  ),
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
    );
  }
}
