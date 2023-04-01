class ClaimAvailableTimeResponse {
  List<ClaimAvailableTimeDataBean> data;

  ClaimAvailableTimeResponse({this.data});

  ClaimAvailableTimeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ClaimAvailableTimeDataBean>();
      json['data'].forEach((v) {
        data.add(new ClaimAvailableTimeDataBean.fromJson(v));
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

class ClaimAvailableTimeDataBean {
  int id;
  String referenceId;
  String name;

  ClaimAvailableTimeDataBean({this.id, this.referenceId, this.name});

  ClaimAvailableTimeDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['name'] = this.name;
    return data;
  }
}
