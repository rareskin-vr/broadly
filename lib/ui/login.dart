import 'package:broadly/ui/verifyotp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double _radius = 20;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 0, 0),
            child: const Text(
              "BROADLY",
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
                        return val!.length == 10
                            ? null
                            : "Enter valid phone number";
                      },
                      controller: phoneNumber,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            letterSpacing: 1),
                        //  errorText: "Enter valid phone number",
                        prefixText: '+91',
                        prefixStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
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
                        hintText: " xxxxx xxxxx",
                        hintStyle: const TextStyle(
                            color: Colors.white70, fontSize: 16),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.indigo,
                    child: IconButton(
                      splashRadius: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Verify()));
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