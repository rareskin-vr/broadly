import 'package:broadly/helper/helpeui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  final String user = "users";
  final String tweet = "all_tweet";
  HelperUI helperUI = HelperUI();
  uploadUserInfo(BuildContext context, userInfo) {
    FirebaseFirestore.instance.collection(user).doc(userId).set(userInfo);
  }

  findUser() {
    return FirebaseFirestore.instance.collection(user).doc(userId).get();
  }

  tweetNow(userTweet) {
    return FirebaseFirestore.instance
        .collection(tweet)
        .doc(user)
        .set(userTweet);
  }

  getUserTweet() {
    return FirebaseFirestore.instance.collection(tweet).doc(user).get();
  }

  getAllTweet() {
    return FirebaseFirestore.instance.collection(tweet).get();
  }
}
