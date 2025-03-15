class NetworkResponse<T> {
  final bool isSuccess;
  final int statusCode;
  final T? responseData;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Something went wrong",
  });
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
