class AppExceptions implements Exception {
  final String? message;
  final String? prifix;
  final String? url;
  AppExceptions({
    this.message,
    this.prifix,
    this.url,
  });
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message, String? url])
      : super(
          message: message,
          prifix: "Bad request",
          url: url,
        );
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message, String? url])
      : super(
          message: message,
          prifix: "Unable to process the request",
          url: url,
        );
}

class ApiNotRespondingException extends AppExceptions {
  ApiNotRespondingException([String? message, String? url])
      : super(
          message: message,
          prifix: "Api not responding",
          url: url,
        );
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message, String? url])
      : super(
          message: message,
          prifix: "Unauthorized request",
          url: url,
        );
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message, String? url])
      : super(
          message: message,
          prifix: "Page not found",
          url: url,
        );
}
