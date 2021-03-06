import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class reportroad extends StatefulWidget {
  @override
  _reportroadState createState() => _reportroadState();
}

class _reportroadState extends State<reportroad> {
  int _valueInt;
  String _dropdownValue;
  List _listValue = [0,1,2,3];
  List _listItem = ['หลุม', 'ซ่อมปะ', 'แตกร้าว', 'ปกติ'];

  DateTime _dateTimeSelect = DateTime.now();
  TextEditingController _controllerDetails =
      TextEditingController(); //prepaer value รายละเอียด
  //Fill
  File img;
  double lat, lng;

  //LatLng latLng = LatLng(16.1995994, 103.2804355); กำหนดตำแหน่ง แบบ fix เอา

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findLatLng(); //หาตำแหน่งก่อนค่อย get location
  }

  //thread ไว้ค้นหาตำแหน่งเวลาเปิดแอฟขึ้นมาอัตโนมัติ
  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  //thred รับตำแหน่ง lat long ถ้าได้ตำแหน่งมาแล้ว ให้วาดตำแหน่งใหม่ เพื่อให้ ืshowmap ขึ้น
  Future<Null> findLatLng() async {
    LocationData locationdata = await findLocationData();
    setState(() {
      lat = locationdata.latitude;
      lng = locationdata.longitude;
    });
    print('Lat=$lat, long=$lng');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งถนนชำรุด'),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                (lat == null) ? showProgress() : showMap(),
                showImageCamera(),
                (img == null)
                    ? Text(
                        '*กรูณาถ่ายภาพ หรือ เลือกรูปภาพ*',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      )
                    : Container(),
                showIconImgCameraGallary(),
                SizedBox(height: 12.0),
                //(img == null) ? Container() : showDatepicker(context),
                (img == null) ? Container() : showLatLngText(),
                (img == null) ? Container() : buildDropdownButton(),
                (img == null)
                    ? Container()
                    : detailsTextField('Details', 'รายละเอียดเพิ่มเติม'),
                (img == null) ? Container() : SaveReport(),
              ],
            ),
          ],
        ),
        color: Colors.white,
        //color: HexColor('#DEDEDE'),
      ),
    );
  }

  //Drowdown ประเถทหลุม
  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'เลือกประเภทของหลุม*',
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton(
              hint: Text(
                'ประเภท',
                style: TextStyle(color: Colors.red),
              ),
              value: _valueInt,
              onChanged: (newValue) {
                setState(() {
                  _valueInt = newValue;
                });
              },
              items: _listValue.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem, child: Text(valueItem.toString()));
              }).toList()),
        ],
      ),
    );
  }

  Widget showLatLngText() {
    return Column(
      children: [
        Text('ละติจูดที่=$lat, ลองติจูด=$lng'),
      ],
    );
  }

  Widget showDatepicker(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "วันที่",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10.0),
        Text(
          "${_dateTimeSelect}".split(' ')[0],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10.0),
        Container(
          child: GestureDetector(
            child: Icon(Icons.calendar_today),
            onTap: () => _slectDate(context),
          ),
        ),
      ],
    );
  }

  Widget showIconImgCameraGallary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(
              Icons.camera,
              size: 35,
            ),
            onPressed: () {
              chooseImge(ImageSource.camera);
            }),
        IconButton(
            icon: Icon(
              Icons.photo_rounded,
              size: 35,
            ),
            onPressed: () {
              chooseImge(ImageSource.gallery);
            }),
      ],
    );
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
            : Image.file(img),
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
            _upload(img);
            //print('valuint=$_valueInt');
            //print(' date time now : ${_dateTimeSelect}');
            //print('Drop down vlue =$_dropdownValue');
           // _uploadToserver();
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            'บันทึกข้อมูล',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  //สร้าง marker บนตำแหน่ง
  Set<Marker> marker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Loation1'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งของคุณ',
          snippet: 'ละติจูด: $lat, ลองติจูด: $lng',
          onTap: () => openOnGoogleMapApp(lat, lng),
        ),
      ),
    ].toSet(); //สร้างเป็นอาเรย์ที่เป็น set
  }

//Null เพราะไม่มีการรีเทินค่าส่งออก
  Future<Null> chooseImge(ImageSource imageSource) async {
    try {
      //maxWidth: 800, maxHeight: 800 กำหนดขนาดรูปภาพสูงสุดของภาพไม่เกิน W-800,H-800 เพื่อไม่ให้ใน server เก็บภาพคุณภาพสูงเกินไป
      var objectImge = await ImagePicker.pickImage(
          source: imageSource, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        img = objectImge;
        print(img);
      });
    } catch (e) {}
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

  //Link ตำแหน่งไปเปิดบน Url Google
  Future<Null> openOnGoogleMapApp(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Cannot Open Google Mapl $googleUrl'; // Could not open the map.
    }
  }

  //ถ่วงเวลาให้ @initstage ค้นหาตำแหน่ง แล้วค่อย showmap()
  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

//ระบุรายละเอียดของข้อมูล
  Widget detailsTextField(String txtLabel, String hintTxt) {
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
            labelText: txtLabel,
            labelStyle: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

//เลือก date time จาก datepicker
  _slectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTimeSelect,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input, //มีช่องให้กรอกวันที่
    );
    if (picked != null && picked != _dateTimeSelect) {
      //เมื่อเวลาไม่เท่า null ก็ให้เอาไปใส่ในตัวแปล gobal + setstate
      setState(() {
        _dateTimeSelect = picked;
      });
    }
  }

  _uploadToserver() {
    if (img != null) {
      //String b64 = base64Encode(img.readAsBytesSync());
      //print('b64=$b64');

      /*var data ={};
      data['datatime']=_dateTimeSelect.toString();
      data['dropdown'] = _dropdownValue.toString();
      data['lng']=lng.toString();
      data['lat']=lat.toString();
      data['detail'] = _controllerDetails.text;
      data['img64'] = base64Encode(img.readAsBytesSync()).toString();
      print(data);
      var encodeJS = jsonEncode(data);
      print(encodeJS);*/

      //-----------------------------------------------------------------------------

    }
  }
    final String endPoint = "http://203.154.83.62:1238/user/upload_file";
   _upload(File file) async {
    if (img != null) {
      String fileName = file.path.split('/').last;
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        "userid": '6',
        //'dateTime':_dateTimeSelect,
        'gps_latitude':lat,
        'gps_longitude':lng,
        'crack_type':_valueInt,
        'detail':_controllerDetails.text

      });
      //print(fileName);
      print(data.fields);
      Dio dio = new Dio();
      dio.post(endPoint, data: data).then((response) {
        var jsonResponse = jsonDecode(response.data);
        print('jsonResponse= $jsonResponse');
        print(response.statusCode);
        print(response.data);

        /*var testData = jsonResponse['histogram_counts'].cast<double>();
        var averageGrindSize = jsonResponse['average_particle_size'];*/
      }).catchError((error) => print(error));
    }
  }
}
