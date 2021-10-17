class reportRecordModel {
  int crackType;
  String date;
  String detail;
  String gpsLatitude;
  String gpsLongitude;
  String photo;
  int predict;
  int roadId;
  int state;
  int userIdFk;
  int repaired;

  reportRecordModel(
      {this.crackType,
        this.date,
        this.detail,
        this.gpsLatitude,
        this.gpsLongitude,
        this.photo,
        this.predict,
        this.roadId,
        this.state,
        this.userIdFk,
      this.repaired});

  reportRecordModel.fromJson(Map<String, dynamic> json) {
    crackType = json['crack_type'];
    date = json['date'];
    detail = json['detail'];
    gpsLatitude = json['gps_latitude'];
    gpsLongitude = json['gps_longitude'];
    photo = json['photo'];
    predict = json['predict'];
    roadId = json['road_id'];
    state = json['state'];
    userIdFk = json['user_id_fk'];
    repaired = json['repaired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crack_type'] = this.crackType;
    data['date'] = this.date;
    data['detail'] = this.detail;
    data['gps_latitude'] = this.gpsLatitude;
    data['gps_longitude'] = this.gpsLongitude;
    data['photo'] = this.photo;
    data['predict'] = this.predict;
    data['road_id'] = this.roadId;
    data['state'] = this.state;
    data['user_id_fk'] = this.userIdFk;
    data['repaired'] = this.repaired;
    return data;
  }
}