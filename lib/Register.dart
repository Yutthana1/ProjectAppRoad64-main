import 'dart:convert';

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
      appBar: AppBar(
        title: Text('Register page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              userTextField('กรอก User หรือ email', 'ชื่อผู้ใช้งานหรืออีเมล์'),
              passWordTextField('กรุณาใส่ Password', 'พาสเวิร์ด'),
              passWordTextFieldAgian(
                  'ใส่ Password อีกครั้ง', 'ใส่พาสเวิร์ดอีกครั้ง'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    registerButton(),
                    cancleButton(),
                  ],
                ),
              ),
            ],
          ),
          //color: HexColor('#DEDEDE'),
        ),
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
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'register'.toUpperCase(),
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
                  if(_passwordController.text == _passwordAgianController.text){
                   /* print('_passwordController=' + _passwordController.text);
                    print(
                        '_errorpPasswordAgian=' + _passwordAgianController.text);*/

                    sentData();
                  }else{
                    print('password ไม่ตรงกัน!! ');
                  }
                } else if (_userController.text == '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController.text == '') {
                  _errorUser = 'โปรดใส่ข้อมูลUser';
                  _errorpPasswordAgian = 'โปรดใส่พาสเวิร์ดอีกครั้ง!';
                  _errorpPassword = null;
                  print('โปรดใส่ข้อมูลUser');
                } else if (_userController.text != '' &&
                    _passwordController.text == '' &&
                    _passwordAgianController.text == '') {
                  _errorpPassword = 'โปรดใส่Password';
                  _errorUser = null;
                  //_errorpPasswordAgian = null;

                } else if (_userController.text != '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController.text == '') {
                  _errorpPasswordAgian = '*โปรดใส่Passwordอีกครั้ง';
                  _errorUser = null;
                  //_errorpPasswordAgian = null;

                } else {
                  _errorUser =
                      _errorpPassword = _errorpPasswordAgian = 'โปรดใส่ข้อมูล';
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
  Future sentData()async{
    var dataRegsiter ={};
    dataRegsiter['username']=_userController.text.trim();//ตัดช่องว่างหน้าหลังง
    dataRegsiter['password']=_passwordController.text.trim();
    //print(dataRegsiter);
    var jsonDataSent = jsonEncode(dataRegsiter);
    print('datasent=$jsonDataSent');
   var response = await http.post(endPoint,body: jsonDataSent);
   print(response.statusCode);
   print(response.body);
   if(response.statusCode==200){
     print('สมัครเพิ่มสำเร็จ');
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
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Cancle'.toUpperCase(),
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
}
