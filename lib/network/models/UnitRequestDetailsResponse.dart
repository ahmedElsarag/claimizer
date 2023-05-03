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
  Null userRemarks;
  Null adminRemarks;
  String createdAt;
  UnitRequestDetailsResponse user;
  // List<CommentsData> comments;

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
        /*this.comments*/});

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
    // if (json['comments'] != null) {
    //   comments = new List<CommentsData>();
    //   json['data'].forEach((v) {
    //     comments.add(new CommentsData.fromJson(v));
    //   });
    // }
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
    // if (this.comments != null) {
    //   data['comments'] = this.comments.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class CommentsData {
//   int id;
//   String comment;
//   String createdAt;
//   List<String> files;
//   UserData user;
//
//   CommentsData({this.id, this.comment, this.createdAt, this.files, this.user});
//
//   CommentsData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     comment = json['comment'];
//     createdAt = json['created_at'];
//     files = json['files'].cast<String>();
//     user = json['user'] != null
//         ? new UserData.fromJson(json['user'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['comment'] = this.comment;
//     data['created_at'] = this.createdAt;
//     data['files'] = this.files;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     return data;
//   }
// }

class UserData {
  int id;
  String refCode;
  String name;
  String email;
  String avatar;

  UserData({this.id, this.refCode, this.name, this.email, this.avatar});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
