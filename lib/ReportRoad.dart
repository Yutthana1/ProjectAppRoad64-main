import 'dart:io';

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
  //Fill
  File img;
  double lat, lng;
  //LatLng latLng = LatLng(16.1995994, 103.2804355); กำหนดตำแหน่ง แบบ fix เอา

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findLatLng();//หาตำแหน่งก่อนค่อย get location
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Container(
                    child: (img == null)
                        ? Image.asset(
                            'images/gallery.png',
                            height: 250,
                          )
                        : Image.file(img),
                  ),
                ),
                Row(
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
                ),
                SaveReport(),
              ],
            ),
          ],
        ),
        color: Colors.white,
        //color: HexColor('#DEDEDE'),
      ),
    );
  }

  Widget SaveReport() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: HexColor('#3C61F0'),
        onPressed: () {},
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'บันทึกข้อมูล',
          style: TextStyle(fontSize: 20, color: Colors.white),
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
          onTap: ()=> openOnGoogleMapApp(lat,lng),
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
      throw 'Cannot Open Google Mapl $googleUrl';// Could not open the map.
    }
  }

  //ถ่วงเวลาให้ @initstage ค้นหาตำแหน่ง แล้วค่อย showmap()
  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
