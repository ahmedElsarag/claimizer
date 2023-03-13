class GeneralResponse {
  dynamic data;
  int status;
  String message;

  GeneralResponse({this.data, this.status, this.message});

  GeneralResponse.fromJson(dynamic json) {
    data = json["data"];
    status = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["data"] = data;
    map["status"] = status;
    map["message"] = message;
    return map;
  }
}
