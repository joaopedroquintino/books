class AppException implements Exception {
  AppException({
    this.message,
    this.code,
  });

  final String? code;
  final String? message;
}
