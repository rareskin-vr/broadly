import 'package:broadly/ui/homepage.dart';
import 'package:broadly/ui/verifyotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/helpeui.dart';

class AuthPh {
  HelperUI helperUI=HelperUI();

  Future registerUser(String mobile, BuildContext context) async {
  helperUI.showLoaderDialog(context,"Sending OTP...");
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((result) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Homepage()));
          });
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          var snackBar = SnackBar(
            content: Text(firebaseAuthException.message.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Verify(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Navigator.pop(context);
          verificationId = verificationId;
          var snackBar = const SnackBar(
            content: Text('Timeout'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
  }
}
