class RoadhistoryModel {
  Null imgProfileBase64Temp;
  String name;
  String nameId;
  String password;
  int uId;
  String username;


  RoadhistoryModel(
      {this.imgProfileBase64Temp,
        this.name,
        this.nameId,
        this.password,
        this.uId,
        this.username,
      });

  RoadhistoryModel.fromJson(Map<String, dynamic> json) {
    imgProfileBase64Temp = json['img_profile_base64_temp'];
    name = json['name'];
    nameId = json['name_id'];
    password = json['password'];
    uId = json['u_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_profile_base64_temp'] = this.imgProfileBase64Temp;
    data['name'] = this.name;
    data['name_id'] = this.nameId;
    data['password'] = this.password;
    data['u_id'] = this.uId;
    data['username'] = this.username;
    return data;
  }
}
