class ProfileResponse {
  ProfileDataBean profileDataBean;

  ProfileResponse({this.profileDataBean});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    profileDataBean = json['data'] != null ? new ProfileDataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileDataBean != null) {
      data['data'] = this.profileDataBean.toJson();
    }
    return data;
  }
}

class ProfileDataBean {
  int id;
  String refCode;
  String name;
  String email;
  String avatar;
  Profile profile;

  ProfileDataBean(
      {this.id,
        this.refCode,
        this.name,
        this.email,
        this.avatar,
        this.profile});

  ProfileDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  String timezone;
  String mobile;
  String gender;
  String locale;
  String status;
  int emailNotifications;
  bool emailVerified;
  Null secondaryEmail;
  int secondaryEmailVerified;

  Profile(
      {this.timezone,
        this.mobile,
        this.gender,
        this.locale,
        this.status,
        this.emailNotifications,
        this.emailVerified,
        this.secondaryEmail,
        this.secondaryEmailVerified});

  Profile.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    mobile = json['mobile'];
    gender = json['gender'];
    locale = json['locale'];
    status = json['status'];
    emailNotifications = json['email_notifications'];
    emailVerified = json['email_verified'];
    secondaryEmail = json['secondary_email'];
    secondaryEmailVerified = json['secondary_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['locale'] = this.locale;
    data['status'] = this.status;
    data['email_notifications'] = this.emailNotifications;
    data['email_verified'] = this.emailVerified;
    data['secondary_email'] = this.secondaryEmail;
    data['secondary_email_verified'] = this.secondaryEmailVerified;
    return data;
  }
}
