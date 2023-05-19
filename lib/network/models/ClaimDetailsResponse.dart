import 'package:Cliamizer/network/models/claims_response.dart';

class ClaimDetailsResponse {
  ClaimsDetailsDataBean data;

  ClaimDetailsResponse({this.data});

  ClaimDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ClaimsDetailsDataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ClaimsDetailsDataBean {
  int id;
  String referenceId;
  String status;
  String description;
  String availableDate;
  String availableTime;
  dynamic employeeId;
  String startDate;
  String endDate;
  String createdBy;
  String priority;
  dynamic rate;
  dynamic feedback;
  String createdAt;
  List<String> files;
  Unit unit;
  Category category;
  Category subCategory;
  Category type;
  Comments comments;

  ClaimsDetailsDataBean(
      {this.id,
        this.referenceId,
        this.status,
        this.description,
        this.availableDate,
        this.availableTime,
        this.employeeId,
        this.startDate,
        this.endDate,
        this.createdBy,
        this.priority,
        this.rate,
        this.feedback,
        this.createdAt,
        this.files,
        this.unit,
        this.category,
        this.subCategory,
        this.type,
        this.comments});

  ClaimsDetailsDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    status = json['status'];
    description = json['description'];
    availableDate = json['available_date'];
    availableTime = json['available_time'];
    employeeId = json['employee_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdBy = json['created_by'];
    priority = json['priority'];
    rate = json['rate'];
    feedback = json['feedback'];
    createdAt = json['created_at'];
    files = json['files'].cast<String>();
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? new Category.fromJson(json['subCategory'])
        : null;
    type = json['type'] != null ? new Category.fromJson(json['type']) : null;
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['status'] = this.status;
    data['description'] = this.description;
    data['available_date'] = this.availableDate;
    data['available_time'] = this.availableTime;
    data['employee_id'] = this.employeeId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_by'] = this.createdBy;
    data['priority'] = this.priority;
    data['rate'] = this.rate;
    data['feedback'] = this.feedback;
    data['created_at'] = this.createdAt;
    data['files'] = this.files;
    if (this.unit != null) {
      data['unit'] = this.unit.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    return data;
  }
}

class Unit {
  int id;
  String code;
  String name;
  String type;
  String building;
  String startAt;
  String endAt;

  Unit(
      {this.id,
        this.code,
        this.name,
        this.type,
        this.building,
        this.startAt,
        this.endAt});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
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
    data['building'] = this.building;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}

class Category {
  int id;
  String code;
  String name;

  Category({this.id, this.code, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class Comments {
  List<CommentsData> data;

  Comments({this.data});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CommentsData>();
      json['data'].forEach((v) {
        data.add(new CommentsData.fromJson(v));
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

class CommentsData {
  int id;
  String comment;
  String createdAt;
  List<String> files;
  User user;

  CommentsData({this.id, this.comment, this.createdAt, this.files, this.user});

  CommentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    files = json['files'].cast<String>();
    user = json['user'] != null
        ? new User.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['files'] = this.files;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  UserData data;

  User({this.data});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

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
