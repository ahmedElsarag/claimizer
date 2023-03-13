class LoginResponse {
  int status;
  Data data;
  String accessToken;
  String tokenType;
  dynamic expiresIn;
  String message;


  LoginResponse(
      {this.status,
      this.data,
      this.accessToken,
      this.tokenType,
      this.expiresIn});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    expiresIn = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['message'] = this.expiresIn;
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  bool isPhoneVerified;
  String image;

  Data({this.id, this.name, this.email, this.isPhoneVerified, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isPhoneVerified = json['phone_is_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_is_verified'] = this.isPhoneVerified;
    data['image'] = this.image;
    return data;
  }
}