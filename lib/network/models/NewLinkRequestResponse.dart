class NewLinkRequestResponse {
  String status;
  String errorName;
  String message;
  NewLinkRequestDataBean data;

  NewLinkRequestResponse({this.status, this.data});

  NewLinkRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorName = json['error_name'];
    message = json['message'];
    data = json['data'] != null ? new NewLinkRequestDataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error_name'] = this.errorName;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class NewLinkRequestDataBean {
  String building;
  String company;
  Units units;

  NewLinkRequestDataBean({this.building, this.company, this.units});

  NewLinkRequestDataBean.fromJson(Map<String, dynamic> json) {
    building = json['building'];
    company = json['company'];
    units = json['units'] != null ? new Units.fromJson(json['units']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building'] = this.building;
    data['company'] = this.company;
    if (this.units != null) {
      data['units'] = this.units.toJson();
    }
    return data;
  }
}

class Units {
  String u22822094;

  Units({this.u22822094});

  Units.fromJson(Map<String, dynamic> json) {
    u22822094 = json['U22-82209-4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['U22-82209-4'] = this.u22822094;
    return data;
  }
}
