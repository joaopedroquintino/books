import 'package:equatable/equatable.dart';

class AppFailure extends Equatable {
  const AppFailure({
    this.message,
  });

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends AppFailure {
  const ServerFailure({
    String? message,
  }) : super(
          message: message,
        );
}
