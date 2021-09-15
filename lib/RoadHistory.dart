import 'dart:async';
import 'dart:convert';

import 'package:approad_project64/EditRoad.dart';
import 'package:approad_project64/models/ReportRecordModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class roadhistory extends StatefulWidget {
  @override
  _roadhistoryState createState() => _roadhistoryState();
}

class _roadhistoryState extends State<roadhistory> {
  FRefreshController controller1;

  List<reportRecordModel> reportRecordList = [];

  //List<RoadhistoryModel> RoadHistoryList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///    FRefresh.debug = true;
    controller1 = FRefreshController();
    controller1.setOnStateChangedCallback((state) {
      print('state = $state');
      if (state is RefreshState) {}
    });
    controller1.setOnScrollListener((metrics) {});
    loadRoadhistory();
  }

  String endPoint = 'http://20.198.233.53:1230/select/road';

  Future<Null> loadRoadhistory() async {
    // WidgetsFlutterBinding.ensureInitialized(); //ทำงานที่ Thread นี้ให้จบก่อน
    try {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติแจ้งถนนชำรุด'),
      ),
      body: Container(
        color: Colors.white,
        child: FRefresh(
          controller: controller1,
          header: Container(
            width: 75.0,
            height: 75.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: OverflowBox(
              maxHeight: 100.0,
              maxWidth: 100.0,
              child: Image.asset(
                "images/icon_refresh3.gif",
                width: 100.0,
                height: 100.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          headerHeight: 75.0,
          onRefresh: () {
            Timer(Duration(milliseconds: 3000), () {
              setState(() {
                loadRoadhistory();
              });
              controller1.finishRefresh();
            });
          },
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 9.0),
            shrinkWrap: true,
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
                            'http://20.198.233.53:1230/photo/${reportRecordList[index].userIdFk}/${reportRecordList[index].photo}')),
                    title: Text(
                      '${indexType(reportRecordList[index].crackType)}',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        (reportRecordList[index].predict == 0)
                            ? IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) =>
                                            new EditRoadHistory(
                                                reportRecordList, index),
                                      )).then((value) {
                                    setState(() {
                                      loadRoadhistory();
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              )
                            : Container(
                                height: 1.0,
                                width: 1.0,
                              ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                            animationDialog_delete(index);
                            //deleteDialog('ลบข้อมูล', 'ยืนยันการลบ', index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
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
      return 'ไม่ทราบ!';
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
    String path = "http://20.198.233.53:1230/delete/reportByid";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    /* var response = await http.post(path,
        body: jsonEncode({'road_id': road_id, 'id_user': userId}),
        headers: {
          'Content-Type': 'application/json'
        }).then((value) => loadRoadhistory());*/

    var dio = Dio();
    var res = await dio
        .post(path, data: jsonEncode({'road_id': road_id, 'id_user': userId}));
    if (res.statusCode == 200) {
       animationDialog_succes();
        /*loadRoadhistory();
        print(jsonDecoDE);*/

    }
  }

   animationDialog_succes() {
     return AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: 'ลบข้อมูลสำเร็จ',
            btnOkOnPress: () {
              controller1.refresh(duration: Duration(milliseconds: 2000));
              debugPrint('OnClcik');
            },
            btnOkIcon: Icons.check_circle,
            )..show();
  }
  animationDialog_delete(int index) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.QUESTION,
        showCloseIcon: true,
        title: 'ลบข้อมูล',
        desc:
        'ยืนยันการลบข้อมูล',
        btnOkOnPress: () {
          print(reportRecordList[index].roadId);
          print(reportRecordList[index].userIdFk);
          int idRoad = reportRecordList[index].roadId;
          DeleteReportByID(idRoad);
          //Navigator.pop(context);
          //debugPrint('OnClcik');
        },
        btnOkText: "ยืนยัน",
        btnCancelOnPress: () {
          debugPrint('cancleClcik');
        },
       btnCancelText: "ยกเลิก",
        btnOkIcon: Icons.check_circle,
        )..show();
  }
}
