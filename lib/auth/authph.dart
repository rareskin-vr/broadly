import 'package:broadly/helper/redirect.dart';
import 'package:broadly/ui/verifyotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/helpeui.dart';

class AuthPh {
  HelperUI helperUI = HelperUI();
    setLoginStat(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', value);
  }

  Future registerUser(String mobile, BuildContext context) async {
    helperUI.showLoaderDialog(context, "Sending OTP...");
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          auth.signInWithCredential(authCredential).then((result) {
            setLoginStat(true);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Redirect()),
                (route) => false);
          });
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          setLoginStat(false);
          var snackBar = SnackBar(
            content: Text(firebaseAuthException.message.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Verify(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setLoginStat(false);
          Navigator.pop(context);
          verificationId = verificationId;
          var snackBar = const SnackBar(
            content: Text('Timeout'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
  }
}
