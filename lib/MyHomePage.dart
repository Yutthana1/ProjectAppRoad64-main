import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:approad_project64/Login.dart';
import 'package:approad_project64/Register.dart';
import 'package:approad_project64/utility/signout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Personal_information.dart';
import 'ReportRoad.dart';
import 'RoadHistory.dart';
import 'Setting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _user_id, _Token,_name,_lastname,_phone;
  bool _isLoggedIn;
  int _point;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();

  }

  Future<Null> _getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _user_id = preferences.getString('userId');
      _Token = preferences.getString('Token');
      _isLoggedIn = preferences.getBool('isLoggedIn');
    });

    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เมนู'),
        //backgroundColor: Colors.orangeAccent,
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
              '$_name $_lastname',
              style: TextStyle(fontSize: 16),
            ),
            accountEmail: Text('เบอร์โทร $_phone\t\t\t\tคะแนน $_point'),

            currentAccountPicture: CircleAvatar(

              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                size: 70,
              ),
            ),
          ),
          (_isLoggedIn != true)
              ? ListTile(
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
                )
              : ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onTap: () => logOut(context),
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

  final String endPoint = "http://203.154.83.62:1238/user/profileID";
  Future getProfile() async{

    int intID_user = int.parse(_user_id);
    print(intID_user);
    Map data = {
      'user_id': intID_user
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(endPoint,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode==200){
      setState(() {
        var bodyDecode = jsonDecode(response.body);
        this._name = bodyDecode['name'];
        this._lastname = bodyDecode['lastname'];
        this._phone = bodyDecode['phone'];
        this._point = bodyDecode['point'];
      });

    }
    print("${response.statusCode}");
    print("${response.body}");

  }
}
