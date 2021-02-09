import 'dart:ui';

import 'package:approad_project64/Login.dart';
import 'package:approad_project64/Register.dart';
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
      drawer: showDrawer(),
      backgroundColor: HexColor('#DEDEDE'),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Test Test11',
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Text('test01@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,

              backgroundImage: NetworkImage(
                  'https://png2.cleanpng.com/sh/b518720bb1dbc76b082144ad2ffcd67a/L0KzQYq3V8A1N6J2gJH0aYP2gLBuTfxwb5CyiNH7dHHlfLa0jvV1f5D3g59wcnHzeLrqk71kdJp1RdN7dD3sfbLuhb11epJzRed8ZYKwfLFuj710bZJ3e9o2cnX2hb37Tcgua51uiNN7dIOwdrF5TgV0baMyhNHwLUXnQbaBgsg5PpJpTaU7LkC5RIGAVsU3OWY7SqQDMki7SIW6V8YveJ9s/kisspng-logo-portable-network-graphics-clip-art-image-tran-user-logo-search-result-8-cliparts-for-user-log-5d1e8b886ad532.0640765615622828884376.png'),
            ),
          ),

          /* DrawerHeader(
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
          ),*/

          ListTile(
            leading: Icon(Icons.login_sharp),
            title: Text('Login'),
            onTap: () => {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new login(),
                ),
              ).then((value) => null),
            },
          ),
          ListTile(
            title: Text('Register'),
            leading: Icon(Icons.person_add_alt_1_sharp),
            onTap: () => {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new register(),
                ),
              ).then((value) => null),
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () => {},
          ),
          ListTile(
            title: Text('Close'),
            leading: Icon(Icons.close),
            onTap: () => {Navigator.pop(context)},
          ),
        ],
      ),
    );
  }
}
