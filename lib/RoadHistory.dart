import 'dart:convert';

import 'package:approad_project64/models/ReportRecordModel.dart';
import 'package:approad_project64/models/RoadHisrtoryModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class roadhistory extends StatefulWidget {
  @override
  _roadhistoryState createState() => _roadhistoryState();
}

class _roadhistoryState extends State<roadhistory> {
  List<reportRecordModel> reportRecordList = []; //ทำถึงนี้นะ
  //List<RoadhistoryModel> RoadHistoryList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadRoadhistory();
  }

  String endPoint = 'http://203.154.83.62:1238/select/road';

  LoadRoadhistory() async {
    /*var str = {'user_id':4};
    var jsonEnCodedata = jsonEncode(str);*/
    final response =
        await http.post(endPoint, body: jsonEncode({'user_id': 4}));
    if (response.statusCode == 200) {
      //print(response.body);
      final jsonDecoDE = jsonDecode(response.body);
      //print(jsonDecoDE);
      setState(() {
        jsonDecoDE.forEach((data) {
          final dataOBJ = reportRecordModel.fromJson(data);
          reportRecordList.add(dataOBJ);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติแจ้งถนนชำรุด'),
      ),
      body: ListView.builder(
        itemCount: reportRecordList.length,
        itemBuilder: (context, index) {
          return ListTile(
          //  leading: Image.network('${reportRecordList[index].photo}'),
            title: Text('${reportRecordList[index].crackType}'),
            trailing: Text('${reportRecordList[index].date}'),
            subtitle: Text('${reportRecordList[index].detail}'),
          );
        },
      ),
    );
  }
}
