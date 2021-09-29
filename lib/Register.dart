import 'dart:convert';

import 'package:approad_project64/Login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _errorUser;

  String _errorpPassword;
  String _errorpPasswordAgian;
  bool _secureText = true;
  bool _secureTextAgain = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _userController.dispose();
    _passwordController.dispose();
    _passwordAgianController.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
                  //  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset('images/pageregister.jpg'),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10, //ขนาดของเงา
                                offset: Offset(0, 5), //ตำแหน่งแสงและเงา
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
                                child: nameTextField('ชื่อ'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: lastnameTextField('นามสกุล'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: userTextField('ชื่อผู้ใช้งานหรืออีเมล์'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: passWordTextField('รหัสผ่าน'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: passWordTextFieldAgian('ยืนยันรหัสผ่าน'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: phoneTextField('เบอร์โทร'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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
          ],
        ),
        //color: HexColor('#DEDEDE'),
      ),
    );
  }

  double sizeText = 15.0;
  double sizeTextButton = 18.0;
  HexColor hexColorFogus = HexColor('#FFBADE');
  HexColor hexColor = HexColor('#FF91AE');

  Widget nameTextField(String txtLabel) {
    return TextField(
      controller: _nameController, //ผูก ยูเซอร์
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: hexColor)),
          // fillColor: Colors.white,
          // filled: true,
          // hoverColor: Colors.red,
          prefixIcon: Icon(
            Icons.person,
            color: hexColor,
          ),
          //hintText: hintTxt,
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: sizeText, color: hexColor),
          border: InputBorder.none
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          // ),
          ),
    );
  }

  Widget lastnameTextField(String txtLabel) {
    return TextField(
      controller: _lastnameController, //ผูก ยูเซอร์
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: hexColor)),
          prefixIcon: Icon(
            Icons.account_box_outlined,
            color: hexColor,
          ),
          // fillColor: Colors.white,
          // filled: true,
          // hoverColor: Colors.blue,
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: sizeText, color: hexColor),
          border: InputBorder.none
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          // ),
          ),
    );
  }

  Widget phoneTextField(String txtLabel) {
    return TextField(
      controller: _phoneController, //ผูก ยูเซอร์
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: hexColor)),
        prefixIcon: Icon(
          Icons.phone,
          color: hexColor,
        ),
        labelText: txtLabel,
        labelStyle: TextStyle(fontSize: sizeText, color: hexColor),
        border: InputBorder.none,
      ),
    );
  }

  Widget userTextField(String txtLabel) {
    return TextField(
      controller: _userController, //ผูก ยูเซอร์
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: hexColorFogus)),
          //fillColor: Colors.white,
          //filled: true,
          // hoverColor: Colors.red,
          errorText: (_errorUser != '') ? _errorUser : null,
          prefixIcon: Icon(
            Icons.account_circle,
            color: hexColor,
          ),
          labelText: txtLabel,
          labelStyle: TextStyle(
            fontSize: sizeText,
            color: hexColor,
          ),
          border: InputBorder.none
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          // ),
          ),
    );
  }

  Widget passWordTextField(String txtLabel) {
    return TextField(
      //axLength: 20,
      controller: _passwordController, //ผูก พาสเวิร์ด
      obscureText: _secureText, //ซ่อน password
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: hexColor)),
          errorText: (_errorpPassword != '') ? _errorpPassword : null,
          suffixIcon: IconButton(
            icon: Icon(
              _secureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye,
              color: hexColor,
            ),
            //เปลี่ยน icon ซ่อน password
            onPressed: () {
              setState(() {
                _secureText = !_secureText; //เปลี่ยนให้เป็นรูปตา แสดง พาสเวิร์ด
              });
            },
          ),
          prefixIcon: Icon(
            Icons.security,
            color: hexColor,
          ),
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: sizeText, color: hexColor),
          border: InputBorder.none
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          // ),
          ),
    );
  }

  Widget passWordTextFieldAgian(String txtLabel) {
    return TextField(
      //axLength: 20,
      controller: _passwordAgianController, //ผูก พาสเวิร์ด
      obscureText: _secureTextAgain, //ซ่อน password
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: hexColor)),
          errorText: (_errorpPasswordAgian != '') ? _errorpPasswordAgian : null,
          suffixIcon: IconButton(
            icon: Icon(
              _secureTextAgain
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye,
              color: hexColor,
            ),
            //เปลี่ยน icon ซ่อน password
            onPressed: () {
              setState(() {
                _secureTextAgain =
                    !_secureTextAgain; //เปลี่ยนให้เป็นรูปตา แสดง พาสเวิร์ด
              });
            },
          ),
          prefixIcon: Icon(
            Icons.security,
            color: hexColor,
          ),
          labelText: txtLabel,
          labelStyle: TextStyle(fontSize: sizeText, color: hexColor),
          border: InputBorder.none
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0), //กำหนดให้ textfild โค้ง
          // ),
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
              color: Colors.blue[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'สมัครสมาชิก'.toUpperCase(),
                style: TextStyle(
                    fontSize: sizeTextButton,
                    color: Colors.white,
                    fontFamily: 'kanit'),
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
                    /* print(_phoneController.text);
                    print(_nameController.text);
                    print(_lastnameController.text);
                    print(_userController.text);*/
                    sentData();
                  } else {
                    // animationDialog_Error();
                    animationDialog_Error(
                        "รหัสผ่านไม่ตรงกัน", "กรุณากรอกรหัสผ่านใหม่อีกครั้ง");
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

                } else if (_userController.text != '' &&
                    _passwordController.text != '' &&
                    _passwordAgianController.text == '') {
                  _errorpPasswordAgian = '*โปรดใส่Passwordอีกครั้ง';
                  _errorUser = null;

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

  var endPoint = 'http://20.198.233.53:1230/user/register';

  Future sentData() async {
    var dataRegsiter = {};
    dataRegsiter['username'] =
        _userController.text.trim(); //ตัดช่องว่างหน้าหลังง
    dataRegsiter['password'] = _passwordController.text.trim();
    dataRegsiter['name'] = _nameController.text.trim();
    dataRegsiter['lastname'] = _lastnameController.text.trim();
    dataRegsiter['phone'] = _phoneController.text.trim();
    //print(dataRegsiter);
    var jsonDataSent = jsonEncode(dataRegsiter);
    print('datasent = $jsonDataSent');
    var response = await http.post(endPoint, body: jsonDataSent);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      animationDialog_succes("สมัครสมาชิกสำเร็จ","ไปที่หน้าล็อคอิน");
      print('สมัครเพิ่มสำเร็จ');
    } else {
      animationDialog_Error("สมัครสมาชิกไม่สำเร็จ", "กรุณาลองใหม่อีกครั้ง");
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
                color: Colors.red[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'ยกเลิก'.toUpperCase(),
                  style: TextStyle(
                      fontSize: sizeTextButton,
                      color: Colors.white,
                      fontFamily: 'kanit'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }



  animationDialog_succes(String title, String desc) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: true,
      dialogType: DialogType.SUCCES,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        MaterialPageRoute rout = MaterialPageRoute(
          builder: (context) => login(),
        );
        Navigator.pushAndRemoveUntil(context, rout, (route) => false);
      },
    )..show();
  }

  animationDialog_Error(String title, String desc) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: title,
        desc: desc,
        btnOkOnPress: () {
          if (title == "รหัสผ่านไม่ตรงกัน") {
            print(title);
          } else {
            print('object $title');
            Navigator.pop(context);
          }
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
}
