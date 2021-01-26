import 'package:flutter/material.dart';

class reportroad extends StatefulWidget {
  @override
  _reportroadState createState() => _reportroadState();
}

class _reportroadState extends State<reportroad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งถนนชำรุด'),
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
