import 'package:flutter/material.dart';

class personaluser extends StatefulWidget {
  @override
  _personaluserState createState() => _personaluserState();
}

class _personaluserState extends State<personaluser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      body: Container(
        color: Colors.yellowAccent,
      ),
    );
  }
}
