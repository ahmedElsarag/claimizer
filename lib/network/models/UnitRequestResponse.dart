class UnitRequestsResponse {
  List<UnitRequestDataBean> data;
  Meta meta;

  UnitRequestsResponse({this.data, this.meta});

  UnitRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UnitRequestDataBean>();
      json['data'].forEach((v) {
        data.add(new UnitRequestDataBean.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class UnitRequestDataBean {
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
  String adminRemarks;
  String createdAt;

  UnitRequestDataBean(
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
        this.createdAt});

  UnitRequestDataBean.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  String next;

  Links({this.next});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    return data;
  }
}
