import 'package:broadly/helper/helpeui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database {
  HelperUI helperUI = HelperUI();
  uploadUserInfo(BuildContext context, String userId, userInfo) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfo)
        .catchError((onError) {
      helperUI.showSnackBar(context, "Something went wrong try again");
    });
  }
}
