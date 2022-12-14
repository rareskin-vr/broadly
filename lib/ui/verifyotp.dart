import 'package:broadly/helper/helpeui.dart';
import 'package:broadly/helper/redirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verify extends StatefulWidget {
  final String verificationId;
  const Verify({Key? key, required this.verificationId}) : super(key: key);
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  setLoginStat(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', value);
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();
  final double _radius = 20;

  @override
  Widget build(BuildContext context) {
    HelperUI helperUI = HelperUI();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: const BackButton(),
      ),
      backgroundColor: Colors.black87,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.03, 0, 0),
            child: const Text(
              "Enter OTP",
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.59,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (val) {
                        return val!.length == 6
                            ? null
                            : "Enter valid OTP number";
                      },
                      controller: otp,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        labelStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            letterSpacing: 1),
                        //  errorText: "Enter valid phone number",

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_radius)),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(_radius)),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.blue,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(_radius)),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(_radius)),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(_radius)),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            )),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.indigo,
                    child: IconButton(
                      splashRadius: 40,
                      onPressed: () {
                        helperUI.showLoaderDialog(
                            context, "Verifying please wait..");

                        FirebaseAuth auth = FirebaseAuth.instance;
                        var code = otp.text.trim();
                        var credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: code);
                        auth.signInWithCredential(credential).then((value) {
                          setLoginStat(true);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Redirect()),
                              (route) => false);
                        }).catchError((e) {
                          setLoginStat(false);
                          var snackBar = SnackBar(
                            content: Text(e.toString()),
                          );
                        });
                      },
                      disabledColor: Colors.indigo,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
