import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../../common/domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required UseCase<UserEntity, dynamic> fetchUserUseCase,
  })  : _fetchUserUseCase = fetchUserUseCase,
        super(UserInitialState());

  final UseCase<UserEntity, dynamic> _fetchUserUseCase;

  Future<void> fetchUser() async {
    emit(UserLoadingState());

    final result = await _fetchUserUseCase();

    result.fold(
      (error) => emit(
        UserErrorState(message: error.message),
      ),
      (user) => emit(
        UserSuccessState(user: user),
      ),
    );
  }
}
