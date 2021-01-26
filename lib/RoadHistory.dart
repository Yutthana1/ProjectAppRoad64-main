import 'dart:convert';

import 'package:approad_project64/models/RoadHisrtoryModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class roadhistory extends StatefulWidget {
  @override
  _roadhistoryState createState() => _roadhistoryState();
}

class _roadhistoryState extends State<roadhistory> {

  List<RoadhistoryModel> RoadHistoryList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadRoadhistory();
  }

  LoadRoadhistory() async {
    final response = await http.get('http://203.154.83.62:1238/del/kuy/small');
    if (response.statusCode == 200) {
      //print(response.statusCode);
      final jsonDecoDE = jsonDecode(response.body);
      // print(jsonDecoDE);
      setState(() {
        jsonDecoDE.forEach((data) {
          final dataOBJ = RoadhistoryModel.fromJson(data);
          if (dataOBJ.uId != '') {
            RoadHistoryList.add(dataOBJ);
          }
          //print(data);
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
        itemCount: RoadHistoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('${RoadHistoryList[index].name}'),
            trailing: Text('${RoadHistoryList[index].nameId}'),
            subtitle: Text('${RoadHistoryList[index].username}'),
          );
        },
      ),
    );
  }
}
