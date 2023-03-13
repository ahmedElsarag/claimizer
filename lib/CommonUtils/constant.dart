class Constant {
  static const bool inProduction =
      const bool.fromEnvironment("dart.vm.product");

  static const String data = "data";
  static const String message = "message";
  static const String code = "code";
  static const String zoomApiKey = "fu2yeKDNZEFqis6ZYBI6YqcCIBzVJE2Ai0Lg";
  static const String zoomSecretKey = "yN7y8p3QuSnlOESyrwUEt4CBTmlWfSwgpSw7";
  static const String socket_start_meeting = 'start_meeting';
  static const String socket_end_meeting = 'end_meeting';
  static const String socket_receive_end_meeting = 'finish_meeting';
  static const String socket_receive_start_meeting = 'new_meeting';
  static const String socket_start = 'start';
}
