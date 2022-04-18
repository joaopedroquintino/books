enum DataStatus { success, error }

abstract class DataReturn {
  DataStatus? status;
  String? message;
  Map<String, dynamic>? body;
  Map<String, dynamic>? headers;
}

class DataError implements DataReturn {
  DataError({
    required this.message,
  });

  @override
  Map<String, dynamic>? body;

  @override
  String? message;

  @override
  DataStatus? status = DataStatus.error;

  @override
  Map<String, dynamic>? headers;
}

class DataSuccess implements DataReturn {
  DataSuccess({
    required this.body,
    this.headers,
  });

  @override
  Map<String, dynamic>? body;

  @override
  String? message;

  @override
  Map<String, dynamic>? headers;

  @override
  DataStatus? status = DataStatus.success;
}
