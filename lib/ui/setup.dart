import 'dart:io';

import 'package:broadly/helper/helpeui.dart';
import 'package:broadly/helper/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  final double _radius = 20;
  int setImg = 1;
  Future profileImgSetter(BuildContext context) async {
    return Provider.of<ImageAccess>(context, listen: false)
        .showImageSource(context);
  }
  HelperUI helperUI = HelperUI();

  validatingNow(ImageAccess access,File profileImg) async {
    if (formKey.currentState!.validate()) {
      {
        helperUI.showLoaderDialog(context, "Please wait");
        access.uploadPic(name.text,profileImg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageAccess access = ImageAccess(context);
    File profileImg = Provider.of<ImageAccess>(context).getImage();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 0, 25),
            child: const Text(
              "Setup Profile",
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Center(
            child: Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(8)),
                  child: profileImg.path == "assets/images/profile.png"
                      ? Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          profileImg,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width * 0.66,
                        )),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        profileImg.path == "assets/images/profile.png"
                            ? {
                                await profileImgSetter(context),
                              }
                            : {
                                access.setImage(),
                                await profileImgSetter(context),
                              };
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 211, 2, 1),
                        ),
                        child: Transform.rotate(
                          angle: setImg == 0 ? 183 : 0,
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (val) {
                        return val!.isEmpty ? 'Enter a Valid Name' : null;
                      },
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.indigo,
                  child: IconButton(
                    splashRadius: 40,
                    onPressed: () {
                      validatingNow(access,profileImg);
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
        ]),
      ),
    );
  }
}
