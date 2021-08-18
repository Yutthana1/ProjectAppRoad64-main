import 'package:approad_project64/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
class personaluser extends StatefulWidget {
  @override
  _personaluserState createState() => _personaluserState();
}

class _personaluserState extends State<personaluser> {
  var _user_id,_name,_lastname,_phone,_point;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      body: buildStack(context),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => HomePage(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        });
      },
      child: Container(
        width: 60,
        height: 60,
        child: Icon(Icons.arrow_forward_ios_rounded),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
            )),
      ),
    );
  }

  Widget buildStack(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
                  ),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 110.0,
                  ),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage('images/user_man.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('${_name} ${_lastname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'เบอร์โทรศัพท์ ${_phone}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                    child: Card(
                        margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                        child: Container(
                            width: 310.0,
                            height: 290.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Information",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: Colors.blueAccent[400],
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ที่อยู่",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            "-",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[400],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                /*  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.auto_awesome,
                                        color: Colors.yellowAccent[400],
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Magic",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            "Spatial & Sword Magic, Telekinesis",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[400],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent[400],
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Loves",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            "Eating cakes",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[400],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: Colors.lightGreen[400],
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Team",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            "Team Natsu",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[400],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),*/
                                ],
                              ),
                            )))),
              ),
            ),
          ],
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 20.0,
            right: 20.0,
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(children: [
                      Text(
                        'อายุ',
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )
                    ]),
                  ),
                  Container(
                      child: Column(
                    children: [
                      Text(
                        'คะแนน',
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${_point}',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )
                    ],
                  )),
                ],
              ),
            )))
      ],
    );
  }

  final String endPoint = "http://20.198.233.53:1230/user/profileID";
  Future getProfile() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
       _user_id = preferences.getString('userId');
    });
    
    int intID_user = int.parse(_user_id);
    print(intID_user);
    Map data = {
      'user_id': intID_user
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(endPoint,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.statusCode==200){
      setState(() {
        var bodyDecode = jsonDecode(response.body);
        this._name = bodyDecode['name'];
        this._lastname = bodyDecode['lastname'];
        this._phone = bodyDecode['phone'];
        this._point = bodyDecode['point'];
      });

    }
    print("${response.statusCode}");
    print("${response.body}");

  }
}
