import 'dart:convert';

import 'package:approad_project64/models/ReportRecordModel.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class roadhistory extends StatefulWidget {
  @override
  _roadhistoryState createState() => _roadhistoryState();
}

class _roadhistoryState extends State<roadhistory> {
  List<reportRecordModel> reportRecordList = [];

  //List<RoadhistoryModel> RoadHistoryList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRoadhistory();
  }

  String endPoint = 'http://203.154.83.62:1238/select/road';

  Future<Null> loadRoadhistory() async {
   // WidgetsFlutterBinding.ensureInitialized(); //ทำงานที่ Thread นี้ให้จบก่อน
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    var response = await http.post(endPoint,
        body: jsonEncode({'user_id': userId}),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //print(response.body);
      final jsonDecoDE = jsonDecode(response.body);
      //print(jsonDecoDE);
      reportRecordList.clear();
      jsonDecoDE.forEach((data) {
        final dataOBJ = reportRecordModel.fromJson(data);
        reportRecordList.add(dataOBJ);
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติแจ้งถนนชำรุด'),
      ),
      body: Container(
        color: Colors.blue.shade200,
        child: ListView.builder(
          itemCount: reportRecordList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              //margin: EdgeInsets.all(5.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                child: ListTile(
                  leading: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Image.network(
                          'http://203.154.83.62:1238/photo/${reportRecordList[index].userIdFk}/${reportRecordList[index].photo}')),
                  title: Text(
                    '${indexType(reportRecordList[index].crackType)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {

                          });
                          deleteDialog('ลบข้อมูล', 'ยืนยันการลบ', index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      '${reportRecordList[index].detail}\n${reportRecordList[index].date.substring(5, 25)}'),
                  isThreeLine: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String indexType(int type) {
    if (type == 0) {
      return 'หลุม';
    } else if (type == 1) {
      return 'ซ่อมปะ';
    } else if (type == 2) {
      return 'แตกร้าว';
    } else if (type == 3) {
      return 'ปกติ';
    }
  }

  deleteDialog(String title, String content, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(fontSize: 22, color: Colors.deepPurple),
          ),
          content: Text(
            '$content',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  print(reportRecordList[index].roadId);
                  print(reportRecordList[index].userIdFk);

                  int idRoad = reportRecordList[index].roadId;
                  Navigator.pop(context);

                  DeleteReportByID(idRoad);
                },
                child: Text('ตกลง')),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ยกเลิก')),
          ],
        );
      },
    );
  }

  DeleteReportByID(int road_id) async {
    String path = "http://203.154.83.62:1238/delete/reportByid";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    /* var response = await http.post(path,
        body: jsonEncode({'road_id': road_id, 'id_user': userId}),
        headers: {
          'Content-Type': 'application/json'
        }).then((value) => loadRoadhistory());*/

    var dio = Dio();
    var res = await dio
        .post(path, data: jsonEncode({'road_id': road_id, 'id_user': userId}))
        .then((value) => loadRoadhistory());
    /*if (response.statusCode == 200) {
      //print(response.body);
      final jsonDecoDE = jsonDecode(response.body);

        loadRoadhistory();
        print(jsonDecoDE);
     
    }*/
  }
}
