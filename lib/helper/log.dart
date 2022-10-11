import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/login.dart';

class Log {
  BuildContext context;
  Log(this.context);
  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await FirebaseAuth.instance.signOut().then((value) => {
          prefs.setBool('logged', false),
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (route) => false),
        });
  }
}
