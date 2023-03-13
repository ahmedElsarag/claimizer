import 'dart:convert';
DefaultResponse defaultResponseFromJson(String str) => DefaultResponse.fromJson(json.decode(str));
String defaultResponseToJson(DefaultResponse data) => json.encode(data.toJson());
class DefaultResponse {
  DefaultResponse({
    this.message,
    this.data,
    this.status,});

  DefaultResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
    status = json['status'];
  }
  String message;
  dynamic data;
  dynamic status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    map['status'] = status;
    return map;
  }

}