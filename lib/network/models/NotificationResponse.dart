class NotificationResponse {
  String status;
  List<NotificationDataBean> data;

  NotificationResponse({this.status, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<NotificationDataBean>();
      json['data'].forEach((v) {
        data.add(new NotificationDataBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDataBean {
  String id;
  Null companyId;
  String type;
  String notifiableType;
  int notifiableId;
  NotificationItemData data;
  Null readAt;
  String createdAt;
  String updatedAt;

  NotificationDataBean(
      {this.id,
        this.companyId,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  NotificationDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new NotificationItemData.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationItemData {
  int id;
  String url;
  String title;
  String updatedAt;
  String subject;

  NotificationItemData({this.id, this.url, this.title, this.updatedAt, this.subject});

  NotificationItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    updatedAt = json['updated_at'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    data['subject'] = this.subject;
    return data;
  }
}
