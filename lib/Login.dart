import 'dart:convert';

import 'package:approad_project64/MyHomePage.dart';
import 'package:approad_project64/Register.dart';
import 'package:approad_project64/main_User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

//import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String _errorUser;
  String _errorpPassword;
  bool _secureText = true;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
  }

  Future<Null> autoLogIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
      if (userId != null) {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => HomePage(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('ล็อคอิน'),
      ),*/
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            HexColor('#F4656D'),
            HexColor('#E4CEE0'),

            /* Colors.purple[600],
            Colors.purple[500],
            Colors.purple[300],*/
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'ล็อคอิน',
                    style: TextStyle(fontSize: 38, color: Colors.white),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'ยินด้อนรับเข้าสู่ระบบแจ้งถนนชำรุด',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20, //ขนาดของเงา
                                offset: Offset(0, 10), //ตำแหน่งแสงและเงา
                                color: Color.fromRGBO(225, 95, 27, 0.3),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: userTextField('ผู้ใช้งาน'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: passWordTextField('รหัสผ่าน'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),

                          /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[400]),*/
                          child: loginButton(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: registerButton('สมัครสมาชิก'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              userTextField('Username', 'ชื่อผู้ใช้งาน'),
              SizedBox(height: 16),
              passWordTextField('Password', 'รหัสผ่าน'),
              SizedBox(height: 25),
              loginButton(), //ปุ่ม login
              SizedBox(height: 20),
              registerTextField('สมัครสมาชิก'),
            ],
          ),
          color: Colors.white,
        ),
      ),*/
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Row(
        children: [
          Expanded(
              //จัดให้ปุ่มเท่ากับหน้าจอ
              child: SizedBox(
            height: 55.0,
            child: RaisedButton(
              color: HexColor("#FF9292"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'login'.toUpperCase(),
                style: TextStyle(
                    fontSize: 24, color: Colors.white, fontFamily: 'kanit'),
              ),
              onPressed: () {
                if (_userController.text != '' &&
                    _passwordController.text != '') {
                  _errorUser = null;
                  _errorpPassword = null;
                  //print('_userController=' + _userController.text);
                  //print('_passwordController=' + _passwordController.text);
                  checkAuthen(); // เมทอด เช็คล็อกอิน
                } else if (_userController.text == '' &&
                    _passwordController.text != '') {
                  _errorUser = 'โปรดใส่ข้อมูลUser';
                  _errorpPassword = null;
                  print('โปรดใส่ข้อมูลUser');
                } else if (_userController.text != '' &&
                    _passwordController.text == '') {
                  _errorpPassword = 'โปรดใส่Password';
                  _errorUser = null;
                  print('โปรดใส่Password');
                } else {
                  _errorUser = _errorpPassword = 'โปรดใส่ข้อมูล';
                  print('โปรดใส่ข้อมูล');
                }
                setState(() {});
              },
            ),
          ))
        ],
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String endPoint = 'http://203.154.83.62:1238/user/login';
    var data = jsonEncode({
      'username': _userController.text.trim(),
      'password': _passwordController.text.trim()
    });
    try {
      var response = await http.post(endPoint, body: data);
      var resJsDe = json.decode(response.body);

      if (response.statusCode == 200) {
        if (resJsDe[0]['token'] != null) {
          var tokenSplit1 = resJsDe[0]['token'].toString().split('.');
          if (tokenSplit1.length == 3) {
            //เช็ค token ว่ามี 3 ส่วนไหม
            var payload = tokenSplit1[1]; //token payload
            var nomalizePayload = base64Url.normalize(payload);
            var resp = utf8.decode(base64Url
                .decode(nomalizePayload)); //ทำให้อยู่ในรูปแบบที่อ่านได้ utf-8
            var jsonPayload = json.decode(resp);
            // print(jsonPayload);
            //print(jsonPayload['user_id']);
            String id = jsonPayload['user_id'];
            String token = resJsDe[0]['token'];

            //if (type =='user'){
            routeToService(HomePage(), token, id);
            // }else if(type =='admin'){ }

          } else {
            print('Invalid Token length==3!!!');
            errorAlert('Error!!!', 'Invalid Token length==3!!!');
          }
        } else {
          print('ไม่มี token มาด้วย!!');
          errorAlert('Error!!!', 'ไม่มี token มาด้วย!!');
        }
      } else {
        print('ไม่พบข้อมูล user!!');
        errorAlert('Error!!!', 'ไม่พบข้อมูล user!!');
      }
    } catch (e) {
      errorAlert('Error!!!', 'ไม่สามารถเข้าสู่ระบบได้ กรูณาลองใหม่อีกครั้ง');
      print('Error !! $e');
    }
  }

// สร้างหน้าที่จะไปแบบ แยก user กับ admin โดยใส่ rout เส้นทางที่จะไป (mypage = หน้าที่จะไป)
  Future<Null> routeToService(Widget mypage, String token, String id) async {
    SharedPreferences preferences =
        await SharedPreferences.getInstance(); //auto login get instant local
    preferences.setString('Token', token); //ฝังลงนนแอป
    preferences.setString('userId', id); //ฝังลงนนแอป
    preferences.setBool('isLoggedIn', true); //ฝังลงนนแอป

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => mypage,
    );
    //Navigator.push(context, route); //ไปหน้าใหม่แบบ push ลง stack ซ้อนทับกันไปเรื่อยๆ
    Navigator.pushAndRemoveUntil(context, route,
        (route) => false); //ไปหน้าใหม่ โดย ลบหน้าเก่าที่อยู่บน stack ออกให้หมด
  }

  Widget registerButton(String str) {
    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width*0.62,
      child: RaisedButton(
        color: Colors.purple[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(str,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        onPressed: (){},
      ),
    );
  }

  Widget registerTextField(String text) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.5,
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
        ),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => register(),
            ),
          );
        },
      ),
    );
  }

  Widget userTextField(String txtLabel /*, String hintTxt*/) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TextField(
        controller: _userController, //ผูก ยูเซอร์
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            errorText: (_errorUser != '') ? _errorUser : null,
            prefixIcon: Icon(Icons.person),
            //hintText: hintTxt,
            labelText: txtLabel,
            labelStyle: TextStyle(
              fontSize: 24,
            ),
            border: InputBorder.none
            /*border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), //กำหนดให้ textfild โค้ง
          ),*/
            ),
      ),
    );
  }

  Widget passWordTextField(String txtLabel /*, String hintTxt*/) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TextField(
        //axLength: 20,
        controller: _passwordController, //ผูก พาสเวิร์ด
        obscureText: _secureText, //ซ่อน password
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            errorText: (_errorpPassword != '') ? _errorpPassword : null,
            suffixIcon: IconButton(
              icon: Icon(_secureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye), //เปลี่ยน icon ซ่อน password
              onPressed: () {
                setState(() {
                  _secureText =
                      !_secureText; //เปลี่ยนให้เป็นรูปตา แสดง พาสเวิร์ด
                });
              },
            ),
            prefixIcon: Icon(
              Icons.security,
            ),
            //hintText: hintTxt,
            labelText: txtLabel,
            labelStyle: TextStyle(fontSize: 24),
            border: InputBorder.none
            /* border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), //กำหนดให้ textfild โค้ง
          ),*/
            ),
      ),
    );
  }

  void errorAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
          content: Text('$content'),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ตกลง'))
          ],
        );
      },
    );
  }
}
