class StatisticsResponse {
  int status;
  Data data;

  StatisticsResponse({this.status, this.data});

  StatisticsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Claims claims;
  ClaimColor claimColor;
  List<AboutToExpireUnits> aboutToExpireUnits;

  Data({this.claims, this.claimColor, this.aboutToExpireUnits});

  Data.fromJson(Map<String, dynamic> json) {
    claims = json['claims'] != null ? new Claims.fromJson(json['claims']) : null;
    claimColor = json['claim_color'] != null ? new ClaimColor.fromJson(json['claim_color']) : null;
    if (json['aboutToExpireUnits'] != null) {
      aboutToExpireUnits = new List<AboutToExpireUnits>();
      json['aboutToExpireUnits'].forEach((v) { aboutToExpireUnits.add(new AboutToExpireUnits.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.claims != null) {
      data['claims'] = this.claims.toJson();
    }
    if (this.claimColor != null) {
      data['claim_color'] = this.claimColor.toJson();
    }
    if (this.aboutToExpireUnits != null) {
      data['aboutToExpireUnits'] = this.aboutToExpireUnits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Claims {
  int all;
  int newClaims;
  int assigned;
  int inProgress;
  int completed;
  int closed;
  int cancelled;

  Claims({this.all, this.newClaims, this.assigned, this.inProgress, this.completed, this.closed, this.cancelled});

  Claims.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    newClaims = json['new'];
    assigned = json['assigned'];
    inProgress = json['in_progress'];
    completed = json['completed'];
    closed = json['closed'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['new'] = this.newClaims;
    data['assigned'] = this.assigned;
    data['in_progress'] = this.inProgress;
    data['completed'] = this.completed;
    data['closed'] = this.closed;
    data['cancelled'] = this.cancelled;
    return data;
  }
}

class ClaimColor {
  String newClaims;
  String assigned;
  String started;
  String completed;
  String closed;
  String cancelled;

  ClaimColor({this.newClaims, this.assigned, this.started, this.completed, this.closed, this.cancelled});

  ClaimColor.fromJson(Map<String, dynamic> json) {
    newClaims = json['new'];
    assigned = json['assigned'];
    started = json['started'];
    completed = json['completed'];
    closed = json['closed'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new'] = this.newClaims;
    data['assigned'] = this.assigned;
    data['started'] = this.started;
    data['completed'] = this.completed;
    data['closed'] = this.closed;
    data['cancelled'] = this.cancelled;
    return data;
  }
}

class AboutToExpireUnits {
  int id;
  String refCode;
  String propertyName;
  String queryCode;
  String startAt;
  String endAt;
  String requestStartAt;
  String requestEndAt;

  AboutToExpireUnits(
      {this.id,
        this.refCode,
        this.propertyName,
        this.queryCode,
        this.startAt,
        this.endAt,
        this.requestStartAt,
        this.requestEndAt});

  AboutToExpireUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    propertyName = json['property_name'];
    queryCode = json['query_code'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    requestStartAt = json['request_start_at'];
    requestEndAt = json['request_end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['property_name'] = this.propertyName;
    data['query_code'] = this.queryCode;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['request_start_at'] = this.requestStartAt;
    data['request_end_at'] = this.requestEndAt;
    return data;
  }
}
