import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/home_datasource.dart';
import 'data/repositories/home_repository.dart';
import 'domain/datasources/home_datasource.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/fetch_books_usecase.dart';
import 'home_routing.dart';
import 'presentation/cubit/home_cubit.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.singleton<HomeDataSource>(
          (i) => HomeDataSourceImpl(
            http: i.get(),
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
        Bind.factory(
          (i) => HomeCubit(
            fetchBooksUseCase: i.get<FetchBooksUseCase>(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
