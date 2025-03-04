class ServerResponse<T> {
  final T? data;
  final bool success;
  final String? errorMessage;

  ServerResponse({this.data, required this.success, this.errorMessage});

  factory ServerResponse.success(T data) {
    return ServerResponse(data: data, success: true);
  }

  factory ServerResponse.error(String errorMessage) {
    return ServerResponse(success: false, errorMessage: errorMessage);
  }
}
