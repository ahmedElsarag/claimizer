class BuildingsResponse {
  List<BuildingsDataBean> data;

  BuildingsResponse({this.data});

  BuildingsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BuildingsDataBean>();
      json['data'].forEach((v) {
        data.add(new BuildingsDataBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BuildingsDataBean {
  int id;
  String refCode;
  String name;
  String company;
  String buildingCode;

  BuildingsDataBean({this.id, this.refCode, this.name, this.company, this.buildingCode});

  BuildingsDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    name = json['name'];
    company = json['company'];
    buildingCode = json['building_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['name'] = this.name;
    data['company'] = this.company;
    data['building_code'] = this.buildingCode;
    return data;
  }
}
