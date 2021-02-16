import 'package:approad_project64/Register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: SingleChildScrollView(
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
      ),
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
              color: Colors.blue,
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
                  print('_userController=' + _userController.text);
                  print('_passwordController=' + _passwordController.text);
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

  Widget userTextField(String txtLabel, String hintTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _userController, //ผูก ยูเซอร์
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          errorText: (_errorUser != '') ? _errorUser : null,
          prefixIcon: Icon(Icons.person),
          hintText: hintTxt,
          labelText: txtLabel,
          labelStyle: TextStyle(
            fontSize: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), //กำหนดให้ textfild โค้ง
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
            borderRadius: BorderRadius.circular(30.0), //กำหนดให้ textfild โค้ง
          ),
        ),
      ),
    );
  }
}
