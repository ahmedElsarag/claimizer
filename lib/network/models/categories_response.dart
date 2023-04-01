class CategoriesResponse {
  List<CategoryDataBean> data;

  CategoriesResponse({this.data});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CategoryDataBean>();
      json['data'].forEach((v) {
        data.add(new CategoryDataBean.fromJson(v));
      });
    }
  }
}

class CategoryDataBean {
  int id;
  String referenceId;
  String name;
  SubCategory subCategory;

  CategoryDataBean({this.id, this.referenceId, this.name, this.subCategory});

  CategoryDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    name = json['name'];
    subCategory = json['child'] != null ? new SubCategory.fromJson(json['child']) : null;
  }
}

class SubCategory {
  List<SubCategoryDataBean> data;

  SubCategory({this.data});

  SubCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SubCategoryDataBean>();
      json['data'].forEach((v) {
        data.add(new SubCategoryDataBean.fromJson(v));
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

class SubCategoryDataBean {
  int id;
  String referenceId;
  String name;

  SubCategoryDataBean({this.id, this.referenceId, this.name});

  SubCategoryDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['name'] = this.name;
    return data;
  }
}
