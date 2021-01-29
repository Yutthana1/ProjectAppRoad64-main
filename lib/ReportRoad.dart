import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class reportroad extends StatefulWidget {
  @override
  _reportroadState createState() => _reportroadState();
}

class _reportroadState extends State<reportroad> {
  File img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งถนนชำรุด'),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: (img == null)
                      ? Icon(
                          Icons.image,
                          size: 250,
                        )
                      : Image.file(img),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.camera,
                          size: 35,
                        ),
                        onPressed: () {
                          chooseImge(ImageSource.camera);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.photo_rounded,
                          size: 35,
                        ),
                        onPressed: () {
                          chooseImge(ImageSource.gallery);
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
        color: HexColor('#6DF9FA'),
      ),
    );
  }
//Null เพราะไม่มีการรีเทินค่าส่งออก
  Future<Null> chooseImge(ImageSource imageSource) async {
    try {
      //maxWidth: 800, maxHeight: 800 กำหนดขนาดรูปภาพสูงสุดของภาพไม่เกิน W-800,H-800 เพื่อไม่ให้ใน server เก็บภาพคุณภาพสูงเกินไป
      var objectImge = await ImagePicker.pickImage(
          source: imageSource, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        img = objectImge;
      });
    } catch (e) {}
  }
}
