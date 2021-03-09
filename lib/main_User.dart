import 'package:approad_project64/Login.dart';
import 'package:approad_project64/utility/signout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class main_user_page extends StatefulWidget {
  @override
  _main_user_pageState createState() => _main_user_pageState();
}

class _main_user_pageState extends State<main_user_page> {
  String user_id;
  String Token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<Null> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('userId');
      Token = preferences.getString('Token');
    });
  }

 /* Future<Null> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();//clear local stored

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => login(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(user_id == null ? 'main_user' : '$user_id Login successfully'),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: Container(
        child: Text(Token == null ? 'Token Null' : 'Token is = $Token'),
      ),
    );
  }
}
