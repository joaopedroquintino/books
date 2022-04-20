enum DataStatus { success, error }

abstract class DataReturn {
  DataStatus? status;
  String? message;
  dynamic body;
  Map<String, dynamic>? headers;
}

class DataError implements DataReturn {
  DataError({
    required this.message,
  });

  @override
  dynamic body;

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
  dynamic body;

  @override
  String? message;

  @override
  Map<String, dynamic>? headers;

  @override
  DataStatus? status = DataStatus.success;
}
