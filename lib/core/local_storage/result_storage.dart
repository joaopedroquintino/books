abstract class ResultStorage {
  late dynamic data;
  late String? message;
  late String? errorMessage;
}

class SuccessData implements ResultStorage {
  SuccessData({
    this.data,
  }) : errorMessage = '';

  @override
  dynamic data;

  @override
  String? errorMessage;

  @override
  String? message;
}

class ErrorData implements ResultStorage {
  ErrorData({
    this.data,
    this.errorMessage,
  }) : message = '';

  @override
  dynamic data;

  @override
  String? errorMessage;

  @override
  String? message;
}
