class AppFailure {
  AppFailure({
    this.message,
  });

  final String? message;
}

class ServerFailure extends AppFailure {
  ServerFailure({
    String? message,
  }) : super(
          message: message,
        );
}
