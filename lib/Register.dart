import 'dart:convert';

import 'package:approad_project64/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgianController = TextEditingController();
  String _errorUser;
  String _errorpPassword;
  String _errorpPasswordAgian;
  bool _secureText = true;
  bool _secureTextAgain = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),*/
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            HexColor('#845EC2'),
            HexColor('#A2C4C6'),

            /*Colors.blue[600],
            Colors.blue[500],
            Colors.blue[300],*/
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
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
                        SizedBox(height: 8),
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
                                child: userTextField('ไอดี', 'ชื่อผู้ใช้งานหรืออีเมล์'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: passWordTextField('รหัสผ่าน', 'รหัสผ่าน'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: passWordTextFieldAgian('ยืนยันรหัสผ่าน', 'ใส่รหัสผ่านอีกครั้ง'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            registerButton(),
                            cancleButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //userTextField('กรอก User หรือ Email', 'ชื่อผู้ใช้งานหรืออีเมล์'),
            //passWordTextField('กรุณาใส่ Password', 'พาสเวิร์ด'),
            /*passWordTextFieldAgian(
                'ใส่ Password อีกครั้ง', 'ใส่พาสเวิร์ดอีกครั้ง'),*/

          ],
        ),
        //color: HexColor('#DEDEDE'),
      ),
    );
  }

  Widget userTextField(String txtLabel, String hintTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _userController, //ผูก ยูเซอร์
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hoverColor: Colors.red,
          errorText: (_errorUser != '') ? _errorUser : null,
          prefixIcon: Icon(Icons.person),
          hintText: hintTxt,
          labelText: txtLabel,
          labelStyle: TextStyle(
            fontSize: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          ),
        ),
      ),
    );
  }

  Widget passWordTextField(String txtLabel, String hintTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        //axLength: 20,
        controller: _passwordController, //ผูก พาสเวิร์ด
        obscureText: _secureText, //ซ่อน password
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          errorText: (_errorpPassword != '') ? _errorpPassword : null,
          suffixIcon: IconButton(
            icon: Icon(_secureText
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye), //เปลี่ยน icon ซ่อน password
            onPressed: () {
              setState(() {
                _secureText = !_secureText; //เปลี่ยนให้เป็นรูปตา แสดง พาสเวิร์ด
              });
            },
          ),
          prefixIcon: Icon(
            Icons.security,
          ),
          hintText: hintTxt,
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          ),
        ),
      ),
    );
  }

  Widget passWordTextFieldAgian(String txtLabel, String hintTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        //axLength: 20,
        controller: _passwordAgianController, //ผูก พาสเวิร์ด
        obscureText: _secureTextAgain, //ซ่อน password
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          errorText: (_errorpPasswordAgian != '') ? _errorpPasswordAgian : null,
          suffixIcon: IconButton(
            icon: Icon(_secureTextAgain
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye), //เปลี่ยน icon ซ่อน password
            onPressed: () {
              setState(() {
                _secureTextAgain =
                    !_secureTextAgain; //เปลี่ยนให้เป็นรูปตา แสดง พาสเวิร์ด
              });
            },
          ),
          prefixIcon: Icon(
            Icons.security,
          ),
          hintText: hintTxt,
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Row(
        children: [
          SizedBox(
            height: 55.0,
            width: MediaQuery.of(context).size.width * .4,
            child: RaisedButton(
              color: Colors.blue[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'สมัครสมาชิก'.toUpperCase(),
                style: TextStyle(
                    fontSize: 24, color: Colors.white, fontFamily: 'kanit'),
              ),
              onPressed: () {
                if (_userController.text != '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController != '') {
                  _errorpPasswordAgian = null;
                  _errorUser = null;
                  _errorpPassword = null;
                  print('_userController=' + _userController.text);
                  //print('_passwordController=' + _passwordController.text);
                  //print('_errorpPasswordAgian=' + _passwordAgianController.text);
                  if (_passwordController.text ==
                      _passwordAgianController.text) {
                    /* print('_passwordController=' + _passwordController.text);
                    print(
                        '_errorpPasswordAgian=' + _passwordAgianController.text);*/

                    sentData();
                  } else {
                    errorAlert('Error!!', 'Password ไม่ตรงกัน!');
                    print('password ไม่ตรงกัน!! ');
                  }
                } else if (_userController.text == '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController.text == '') {
                  _errorUser = 'โปรดใส่ข้อมูลUser';
                  _errorpPasswordAgian = 'โปรดใส่พาสเวิร์ดอีกครั้ง!';
                  _errorpPassword = null;
                  //errorAlert('Error!!','$_errorUser และ $_errorpPasswordAgian');
                  print('โปรดใส่ข้อมูลUser');
                } else if (_userController.text != '' &&
                    _passwordController.text == '' &&
                    _passwordAgianController.text == '') {
                  _errorpPassword = 'โปรดใส่Password';
                  _errorUser = null;
                  //errorAlert('Error!!', '$_errorpPassword');
                  //_errorpPasswordAgian = null;

                } else if (_userController.text != '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController.text == '') {
                  _errorpPasswordAgian = '*โปรดใส่Passwordอีกครั้ง';
                  _errorUser = null;
                  //errorAlert('Error!!', _errorpPasswordAgian);
                  //_errorpPasswordAgian = null;

                } else {
                  _errorUser =
                      _errorpPassword = _errorpPasswordAgian = 'โปรดใส่ข้อมูล';
                  //errorAlert('Error!!', 'โปรดใส่ข้อมูล');
                }
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  var endPoint = 'http://203.154.83.62:1238/user/register';

  Future sentData() async {
    var dataRegsiter = {};
    dataRegsiter['username'] =
        _userController.text.trim(); //ตัดช่องว่างหน้าหลังง
    dataRegsiter['password'] = _passwordController.text.trim();
    //print(dataRegsiter);
    var jsonDataSent = jsonEncode(dataRegsiter);
    print('datasent=$jsonDataSent');
    var response = await http.post(endPoint, body: jsonDataSent);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print('สมัครเพิ่มสำเร็จ');
      myAlert('สมัคร', 'สมัครสมาชิกสำเร็จ');
    } else {
      errorAlert('Error!!!${response.statusCode}', 'สมัครสมาชิกไม่สำเร็จ!!');
    }
  }

  Widget cancleButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Row(
        children: [
          SizedBox(
            height: 55.0,
            width: MediaQuery.of(context).size.width * .4,
            child: RaisedButton(
                color: Colors.red[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'ยกเลิก'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: 'kanit'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }

  void myAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$content'),
          actions: [
            FlatButton(
                onPressed: () {
                  MaterialPageRoute rout = MaterialPageRoute(
                    builder: (context) => login(),
                  );
                  Navigator.pushAndRemoveUntil(context, rout, (route) => false);
                },
                child: Text('ตกลง')),
            FlatButton(
                onPressed: () {
                  MaterialPageRoute rout = MaterialPageRoute(
                    builder: (context) => login(),
                  );
                  Navigator.pushAndRemoveUntil(context, rout, (route) => false);
                },
                child: Text('ยกเลิก'))
          ],
        );
      },
    );
  }

  void errorAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
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
