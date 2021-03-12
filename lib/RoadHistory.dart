import 'dart:convert';

import 'package:approad_project64/models/ReportRecordModel.dart';
import 'package:approad_project64/models/RoadHisrtoryModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    final response =
        await http.post(endPoint, body: jsonEncode({'user_id': userId}));
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
            leading: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.network(
                    'http://203.154.83.62:1238/photo/${reportRecordList[index].userIdFk}/${reportRecordList[index].photo}')),
            title: Text(
              '${reportRecordList[index].crackType}',
              style: TextStyle(fontSize: 22),
            ),
            trailing: Text('${reportRecordList[index].roadId}'),
            subtitle: Text(
                '${reportRecordList[index].detail} \n${reportRecordList[index].date.substring(4, 25)}'),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
