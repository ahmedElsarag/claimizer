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
 dynamic date;
 dynamic diffDate;
  List<Items> items;

  NotificationDataBean({this.date, this.diffDate, this.items});

  NotificationDataBean.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    diffDate = json['diff_date'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['diff_date'] = this.diffDate;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  dynamic model;
  dynamic modelId;
  dynamic url;
  dynamic title;

  Items({this.model, this.modelId, this.url, this.title});

  Items.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    modelId = json['model_id'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['model_id'] = this.modelId;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}
