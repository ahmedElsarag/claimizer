class ClaimsResponse {
  List<ClaimsDataBean> data;
  Meta meta;

  ClaimsResponse({this.data, this.meta});

  ClaimsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != dynamic) {
      data = new List<ClaimsDataBean>();
      json['data'].forEach((v) {
        data.add(new ClaimsDataBean.fromJson(v));
      });
    }
    meta = json['meta'] != dynamic ? new Meta.fromJson(json['meta']) : dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != dynamic) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != dynamic) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class ClaimsDataBean {
  int id;
  String referenceId;
  dynamic acceptedTime;
  String description;
  String availableDate;
  String availableTime;
  dynamic startAt;
  dynamic endAt;
  dynamic startDate;
  dynamic endDate;
  dynamic acceptedBy;
  dynamic employeeId;
  int categoryId;
  int subCategoryId;
  int propertyId;
  int createdBy;
  int companyId;
  String priority;
  String status;
  int boardColumnId;
  dynamic completedOn;
  String createdAt;
  int claimTypeId;
  dynamic rate;
  dynamic feedback;

  ClaimsDataBean(
      {this.id,
      this.referenceId,
      this.acceptedTime,
      this.description,
      this.availableDate,
      this.availableTime,
      this.startAt,
      this.endAt,
      this.startDate,
      this.endDate,
      this.acceptedBy,
      this.employeeId,
      this.categoryId,
      this.subCategoryId,
      this.propertyId,
      this.createdBy,
      this.companyId,
      this.priority,
      this.status,
      this.boardColumnId,
      this.completedOn,
      this.createdAt,
      this.claimTypeId,
      this.rate,
      this.feedback});

  ClaimsDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    acceptedTime = json['accepted_time'];
    description = json['description'];
    availableDate = json['available_date'];
    availableTime = json['available_time'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    acceptedBy = json['accepted_by'];
    employeeId = json['employee_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    propertyId = json['property_id'];
    createdBy = json['created_by'];
    companyId = json['company_id'];
    priority = json['priority'];
    status = json['status'];
    boardColumnId = json['board_column_id'];
    completedOn = json['completed_on'];
    createdAt = json['created_at'];
    claimTypeId = json['claim_type_id'];
    rate = json['rate'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['accepted_time'] = this.acceptedTime;
    data['description'] = this.description;
    data['available_date'] = this.availableDate;
    data['available_time'] = this.availableTime;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['accepted_by'] = this.acceptedBy;
    data['employee_id'] = this.employeeId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['property_id'] = this.propertyId;
    data['created_by'] = this.createdBy;
    data['company_id'] = this.companyId;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['board_column_id'] = this.boardColumnId;
    data['completed_on'] = this.completedOn;
    data['created_at'] = this.createdAt;
    data['claim_type_id'] = this.claimTypeId;
    data['rate'] = this.rate;
    data['feedback'] = this.feedback;
    return data;
  }
}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != dynamic ? new Pagination.fromJson(json['pagination']) : dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != dynamic) {
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

  Pagination({this.total, this.count, this.perPage, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
