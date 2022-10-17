import 'package:broadly/database/database.dart';
import 'package:broadly/helper/userdata.dart';
import 'package:broadly/ui/homepage.dart';
import 'package:broadly/ui/setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Redirect extends StatefulWidget {
  const Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  final Database _databaseInfo=Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: _databaseInfo.findUser(),builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasData){
          if(snapshot.data!.exists){
            String name = snapshot.data!.get("name");
            String imgPath = snapshot.data!.get("imageUrl");
            UserData userData=UserData(name: name, imgPath: imgPath);
            return Homepage(userData: userData);
          }
          else{
            return const Setup();
          }
        }
        else
        {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
