class UnitsResponse {
  List<UnitsDataBean> data;

  UnitsResponse({this.data});

  UnitsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UnitsDataBean>();
      json['data'].forEach((v) {
        data.add(new UnitsDataBean.fromJson(v));
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

class UnitsDataBean {
  int id;
  String code;
  String name;
  String type;
  String company;
  int companyId;
  String building;
  String startAt;
  String endAt;

  UnitsDataBean(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.company,
      this.companyId,
      this.building,
      this.startAt,
      this.endAt});

  UnitsDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    company = json['company'];
    companyId = json['company_id'];
    building = json['building'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['type'] = this.type;
    data['company'] = this.company;
    data['company_id'] = this.companyId;
    data['building'] = this.building;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}
