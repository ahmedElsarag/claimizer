class ClaimsRequestResponse {
  String message;
  String id;

  ClaimsRequestResponse({this.message, this.id});

  ClaimsRequestResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}
