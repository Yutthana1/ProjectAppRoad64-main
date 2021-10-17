import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/ReportRecordModel.dart';

class EditRoadHistory extends StatefulWidget {
  List<reportRecordModel> reportRecordList;
  int index;

  EditRoadHistory(List<reportRecordModel> reportRecordList, int index) {
    this.reportRecordList = reportRecordList;
    this.index = index;
  }

  @override
  _EditRoadHistoryState createState() =>
      _EditRoadHistoryState(reportRecordList, index);
}

class _EditRoadHistoryState extends State<EditRoadHistory> {
  TextEditingController _controllerDetails = TextEditingController();
  //String detail;
  List<reportRecordModel> reportRecordList;
  int index;
  var lat;
  var lng;
  int _cracktype;
  String _dropdownValue;
  List _listItem = ['หลุม', 'แตกร้าว'];
  String img;

  var uid;

  _EditRoadHistoryState(List<reportRecordModel> reportRecordList, int index) {
    this.reportRecordList = reportRecordList;
    this.index = index;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      lat = double.parse(reportRecordList[index].gpsLatitude);
      lng = double.parse(reportRecordList[index].gpsLongitude);
      img = reportRecordList[index].photo;
      uid = reportRecordList[index].userIdFk;
      _cracktype = reportRecordList[index].crackType;
      _dropdownValue = ConvertTypeDropdown(_cracktype);
      //detail = reportRecordList[index].detail;
      _controllerDetails.text = reportRecordList[index].detail;
    });
    super.initState();
  }
  @override
  void dispose() {
    _controllerDetails.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูล"),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                (lat == null) ? showProgress() : showMap(),
                (img != null)
                    ? showImageCamera()
                    : Container(
                        child: Text('ไม่พบรูปภาพ!'),
                      ),
                SizedBox(height: 12.0),
                (img == null) ? Container() : Card_Lat_Lng(lat,lng),
                (img == null) ? Container() : buildDropdownButton(),
                (img == null) ? Container() : detailsTextField( _controllerDetails.text),
                (img == null) ? Container() : SaveReport(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15.5);

    return Container(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: marker(),
        myLocationEnabled: true, //button getlocation
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Set<Marker> marker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Loation1'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งของคุณ',
          snippet: 'ละติจูด: $lat, ลองติจูด: $lng',
        ),
      ),
    ].toSet(); //สร้างเป็นอาเรย์ที่เป็น set
  }

  Widget showImageCamera() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        child: (img == null)
            ? Image.asset(
                'images/gallery.png',
                height: 250,
              )
            : Image.network(
                "http://20.198.233.53:1230/photo/$uid/$img",
                fit: BoxFit.fill,
              ),
      ),
    );
  }



  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ประเภทของหลุม*',
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton(
              hint: (_dropdownValue != null)
                  ? Text(
                      "$_dropdownValue",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text('ไม่พบข้อมูล!'),
              value: _dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  _dropdownValue = newValue;
                });
              },
              items: _listItem.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem, child: Text(valueItem.toString()));
              }).toList()),
        ],
      ),
    );
  }

  String ConvertTypeDropdown(int value) {
    if (value == 0) {
      return _dropdownValue = 'หลุม';
    } else if (value == 1) {
      return _dropdownValue = 'แตกร้าว';
    } else if (value == 2) {
      return _dropdownValue = 'ซ่อมปะ';
    }
  }

  Widget detailsTextField(String hintTxt) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 2,
          controller: _controllerDetails, //ผูก ยูเซอร์
          //keyboardType: TextInputType.name,
          decoration: InputDecoration(
            helperText: '-อธิบายเกี่ยวกับหลุม',
            suffixIcon: Icon(Icons.details),
            hintText: hintTxt,
            labelStyle: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget SaveReport() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .06,
        child: RaisedButton.icon(
          elevation: 15.0,
          shape: StadiumBorder(),
          color: HexColor('#3b38ea'),
          onPressed: () {
            _EditState();
            print('$_dropdownValue\n${_controllerDetails.text}');
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            'ยืนยันการแก้ไข',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<Null> _EditState() async {
    final String endPoint = "http://20.198.233.53:1230/update/road";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString('userId');
    if (reportRecordList != null) {
      int _varDropInt;
      if (_dropdownValue == 'หลุม') {
        _varDropInt = 0;
      } else if (_dropdownValue == 'แตกร้าว' ) {
        _varDropInt = 1;
      } else if (_dropdownValue == 'ซ่อมปะ') {
        _varDropInt = 2;
      }
      try {
       var data = {};
         data["road_id"]= reportRecordList[index].roadId;
         data["id_user"]= userId;
          data["detail"]= _controllerDetails.text;
          data["crack_type"]= _varDropInt;

        Dio dio = new Dio();
        dio.post(endPoint, data: jsonEncode(data)).then((value) {
          Navigator.pop(context);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Widget Card_Lat_Lng(double lat, double lng){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding:
          EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
              color: Color(0xff1b232f),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    lat.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'ละติจูด',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    lng.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'ละจิจูด',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
