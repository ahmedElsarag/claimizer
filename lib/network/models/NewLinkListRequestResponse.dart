class NewLinkListRequestResponse {
  String status;
  NewLinkListRequestDataBean data;

  NewLinkListRequestResponse({this.status, this.data});

  NewLinkListRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new NewLinkListRequestDataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class NewLinkListRequestDataBean {
  String building;
  String company;
  List<UnitsList> units;

  NewLinkListRequestDataBean({this.building, this.company, this.units});

  NewLinkListRequestDataBean.fromJson(Map<String, dynamic> json) {
    building = json['building'];
    company = json['company'];
    if (json['units'] != null) {
      units = new List<UnitsList>();
      json['units'].forEach((v) {
        units.add(new UnitsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building'] = this.building;
    data['company'] = this.company;
    if (this.units != null) {
      data['units'] = this.units.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnitsList {
  int id;
  String code;
  String propertyName;

  UnitsList({this.id, this.code, this.propertyName});

  UnitsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    propertyName = json['property_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['property_name'] = this.propertyName;
    return data;
  }
}
