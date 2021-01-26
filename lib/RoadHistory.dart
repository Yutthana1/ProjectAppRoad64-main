import 'package:flutter/material.dart';

class roadhistory extends StatefulWidget {
  @override
  _roadhistoryState createState() => _roadhistoryState();
}

class _roadhistoryState extends State<roadhistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติแจ้งถนนชำรุด'),
      ),
      body: Container(
        color: Colors.greenAccent,
      ),
    );
  }
}
