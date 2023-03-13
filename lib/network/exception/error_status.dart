///Manage the status of error codes
class ErrorStatus {
  //Code of successful data
  static const int REQUEST_DATA_OK = 0;

  //The request is successful
  static const int SUCCESS = 200;

  //The request is successful
  static const int NO_CONTENT = 204;

  //The server access FORBIDDEN
  static const int FORBIDDEN = 403;

  static const int NOT_FOUND = 404;

  //Other errors
  static const int UNKNOWN_ERROR = 1000;

  //network error
  static const int NETWORK_ERROR = 1001;

  //Server connection error
  static const int SOCKET_ERROR = 1002;

  //internal Server error
  static const int SERVER_ERROR = 1003;

  //TIMEOUT_ERROR
  static const int TIMEOUT_ERROR = 1004;

  //CANCEL_ERROR
  static const int CANCEL_ERROR = 1005;

  //PARSE_ERROR
  static const int PARSE_ERROR = 1006;

  //UNAUTHORIZED
  static const int UNAUTHORIZED = 401;
}
