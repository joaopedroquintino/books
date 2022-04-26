import 'package:flutter_modular/flutter_modular.dart';

import '../../core/local_storage/local_storage_imp.dart';
import '../common/domain/usecases/fetch_user_usecase.dart';
import '../common/domain/usecases/remove_authentication_usecase.dart';
import 'data/datasources/home_datasource.dart';
import 'data/repositories/home_repository.dart';
import 'domain/datasources/home_datasource.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/favorite_book_usecase.dart';
import 'domain/usecases/fetch_book_details_usecase.dart';
import 'domain/usecases/fetch_books_usecase.dart';
import 'domain/usecases/fetch_favorite_books_usecase.dart';
import 'home_routing.dart';
import 'presentation/cubits/book_details/book_details_cubit.dart';
import 'presentation/cubits/favorite/favorite_cubit.dart';
import 'presentation/cubits/home/home_cubit.dart';
import 'presentation/cubits/user/user_cubit.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.singleton<HomeDataSource>(
          (i) => HomeDataSourceImpl(
            http: i.get(),
            database: i.get<LocalStorageImpDao>(),
          ),
        ),
        Bind.singleton<HomeRepository>(
          (i) => HomeRepositoryImpl(
            homeDataSource: i.get<HomeDataSource>(),
          ),
        ),
        Bind.singleton(
          (i) => FetchBooksUseCase(
            homeRepository: i.get<HomeRepository>(),
          ),
        ),
        Bind.singleton(
          (i) => FetchBookDetailsUseCase(
            homeRepository: i.get<HomeRepository>(),
          ),
        ),
        Bind.singleton(
          (i) => FavoriteBookUseCase(
            homeRepository: i.get<HomeRepository>(),
          ),
        ),
        Bind.singleton(
          (i) => FetchFavoriteBooksUseCase(
            homeRepository: i.get<HomeRepository>(),
          ),
        ),
        Bind.factory(
          (i) => HomeCubit(
            fetchBooksUseCase: i.get<FetchBooksUseCase>(),
            removeAuthenticationUseCase: i.get<RemoveAuthenticationUseCase>(),
            favoriteBookUseCase: i.get<FavoriteBookUseCase>(),
            fetchFavoriteBooksUseCase: i.get<FetchFavoriteBooksUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => FavoriteCubit(
            favoriteBookUseCase: i.get<FavoriteBookUseCase>(),
            fetchFavoriteBooksUseCase: i.get<FetchFavoriteBooksUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => BookDetailsCubit(
            fetchBookDetailsUseCase: i.get<FetchBookDetailsUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => UserCubit(
            fetchUserUseCase: i.get<FetchUserUseCase>(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
