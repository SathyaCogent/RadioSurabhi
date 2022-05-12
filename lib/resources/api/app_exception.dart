class AppException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, " ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, " ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(
            message,
            DateTime.now().toIso8601String() +
                " Session expired. Login again.");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
