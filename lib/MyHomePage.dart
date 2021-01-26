import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Personal_information.dart';
import 'ReportRoad.dart';
import 'RoadHistory.dart';
import 'Setting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เมนู'),
      ),
      body: GridView.count(
        //primary: false,
        padding: const EdgeInsets.all(25),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => reportroad(),
                    ));
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/map.png',
                      width: 100,
                    ),
                    Text(
                      'แจ้งถนนชำรุด',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => roadhistory(),
                    ));
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/document.png',
                      width: 100,
                    ),
                    Text(
                      'ประวัติแจ้งถนนชำรุด',
                      style: TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => personaluser(),
                    ));
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/user_man.png',
                      width: 100,
                    ),
                    Text(
                      'ข้อมูลส่วนตัว',
                      style: TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setting(),
                    ));
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/Settings-icon.png',
                      width: 100,
                    ),
                    Text(
                      'ตั้งค่า',
                      style: TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                    ),
                    Text(
                      'Hello Maki losuss',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: HexColor('#DEDEDE'),
    );
  }
}
