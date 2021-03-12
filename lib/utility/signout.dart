
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';

Future<Null> logOut(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('Token');//clear local stored
  preferences.remove('userId');//clear local stored
  preferences.remove('isLoggedIn');//clear local stored

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => login(),
  );
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}


