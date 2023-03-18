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

  Data({this.claims, this.claimColor});

  Data.fromJson(Map<String, dynamic> json) {
    claims = json['claims'] != null ? new Claims.fromJson(json['claims']) : null;
    claimColor = json['claim_color'] != null ? new ClaimColor.fromJson(json['claim_color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.claims != null) {
      data['claims'] = this.claims.toJson();
    }
    if (this.claimColor != null) {
      data['claim_color'] = this.claimColor.toJson();
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
