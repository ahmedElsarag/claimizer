class UnitRequestDetailsResponse {
  UnitRequestDetailsDataBean data;

  UnitRequestDetailsResponse({this.data});

  UnitRequestDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UnitRequestDetailsDataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UnitRequestDetailsDataBean {
  int id;
  String refCode;
  int userId;
  int unitId;
  String unitName;
  String buildingName;
  String unitType;
  String company;
  String startAt;
  String endAt;
  String contractNumber;
  String contractAttach;
  String clientGovId;
  String status;
  dynamic userRemarks;
  dynamic adminRemarks;
  String createdAt;
  UnitRequestDetailsResponse user;
  List<Comments> comments;

  UnitRequestDetailsDataBean(
      {this.id,
        this.refCode,
        this.userId,
        this.unitId,
        this.unitName,
        this.buildingName,
        this.unitType,
        this.company,
        this.startAt,
        this.endAt,
        this.contractNumber,
        this.contractAttach,
        this.clientGovId,
        this.status,
        this.userRemarks,
        this.adminRemarks,
        this.createdAt,
        this.user,
        this.comments});

  UnitRequestDetailsDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    userId = json['user_id'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    buildingName = json['building_name'];
    unitType = json['unit_type'];
    company = json['company'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    contractNumber = json['contract_number'];
    contractAttach = json['contract_attach'];
    clientGovId = json['client_gov_id'];
    status = json['status'];
    userRemarks = json['user_remarks'];
    adminRemarks = json['admin_remarks'];
    createdAt = json['created_at'];
    user = json['user'] != null
        ? new UnitRequestDetailsResponse.fromJson(json['user'])
        : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['user_id'] = this.userId;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['building_name'] = this.buildingName;
    data['unit_type'] = this.unitType;
    data['company'] = this.company;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['contract_number'] = this.contractNumber;
    data['contract_attach'] = this.contractAttach;
    data['client_gov_id'] = this.clientGovId;
    data['status'] = this.status;
    data['user_remarks'] = this.userRemarks;
    data['admin_remarks'] = this.adminRemarks;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int id;
  String content;
  User user;
  String createdAt;
  List<String> files;

  Comments({this.id, this.content, this.user, this.createdAt, this.files});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    files = json['files'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['created_at'] = this.createdAt;
    data['files'] = this.files;
    return data;
  }
}

class User {
  int id;
  String name;
  String avatar;

  User({this.id, this.name, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}
