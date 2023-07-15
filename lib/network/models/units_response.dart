class UnitsResponse {
  List<UnitsDataBean> data;
  Meta meta;

  UnitsResponse({this.data});

  UnitsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UnitsDataBean>();
      json['data'].forEach((v) {
        data.add(new UnitsDataBean.fromJson(v));
      });
      meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    }
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

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
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

  Pagination({this.total, this.count, this.perPage, this.currentPage, this.totalPages, this.links});

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
