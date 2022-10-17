import 'package:broadly/helper/helpeui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  HelperUI helperUI = HelperUI();
  uploadUserInfo(BuildContext context,userInfo) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfo)
        .catchError((onError) {
      helperUI.showSnackBar(context, "Something went wrong try again");
    });
  }
  findUser() {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }
}
