import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../cubits/favorite/favorite_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/user/user_cubit.dart';
import 'favorite_books_page.dart';
import 'home_books_page.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends ModularState<MobileHomePage, HomeCubit> {
  final scrollController = ScrollController();
  late UserCubit userCubit;
  late FavoriteCubit favoriteCubit;
  int currentPage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    cubit.fetchBooks();
    userCubit = Modular.get<UserCubit>()..fetchUser();
    favoriteCubit = Modular.get<FavoriteCubit>()..fetchFavoriteBooks();
    pages = [
      HomeBooksPage(
        cubit: cubit,
        userCubit: userCubit,
        scrollController: scrollController,
      ),
      FavoriteBooksPage(
        cubit: cubit,
        favoriteCubit: favoriteCubit,
        scrollController: scrollController,
      ),
    ];

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
          child: pages[currentPage],
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? null
          : BottomNavigationBar(
              currentIndex: currentPage,
              onTap: (page) {
                setState(() {
                  currentPage = page;
                  if (page == 1) {
                    favoriteCubit.fetchFavoriteBooks();
                  }
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Favoritos',
                )
              ],
              backgroundColor: AppDS.color.contrast,
              selectedItemColor: AppDS.color.white,
              unselectedItemColor: AppDS.color.white.withOpacity(.5),
            ),
    );
  }
}
