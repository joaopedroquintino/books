import 'package:dartz/dartz.dart';

import '../../../shared/errors/app_failure.dart';

abstract class UseCase<R, P> {
  Future<Either<AppFailure, R>> call([P params]);
}
