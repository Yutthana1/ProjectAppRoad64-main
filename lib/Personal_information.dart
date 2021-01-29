import 'package:flutter/material.dart';

class personaluser extends StatefulWidget {
  @override
  _personaluserState createState() => _personaluserState();
}

class _personaluserState extends State<personaluser> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      body: Container(
        color: Colors.yellowAccent,
        child: Image.network('https://miro.medium.com/max/500/1*in7MRIAKfRn-qDgJKc9XVw.jpeg'),
      ),
    );
  }
}
