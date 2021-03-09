
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';

Future<Null> logOut(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();//clear local stored

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => login(),
  );
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
