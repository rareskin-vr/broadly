import 'dart:io';

import 'package:broadly/database.dart';
import 'package:broadly/helper/helpeui.dart';
import 'package:broadly/ui/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ImageAccess extends ChangeNotifier {
  Database database = Database();
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  File image = File("assets/images/profile.png");
  BuildContext context;
  void setImage() {
    image = File("assets/images/profile.png");
  }

  File getImage() {
    return image;
  }

  ImageAccess(this.context);

  HelperUI helperUI = HelperUI();
  Future getImageCamera() async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.camera)
          .then((value) {
        final imageTemp = File(value!.path);
        image = imageTemp;
        notifyListeners();
      });
    } catch (e) {
      helperUI.showSnackBar(context, "Couldn't load image");
    }
  }

  Future getImageGallery() async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)
          .then((value) {
        final imageTemp = File(value!.path);
        image = imageTemp;
        notifyListeners();
      });
    } catch (e) {
      helperUI.showSnackBar(context, "Couldn't load image");
    }
  }

  Future showImageSource(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: const Text('Camera'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: const Text('Gallery'),
                  ),
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Gallery'),
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
    }
  }

  Future uploadPic(String name,File image) async {
    print("working 1");
    print(image.path);
    String filename = Path.basename(image.path);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child('UserProfile/$userId/$filename');
    UploadTask uploadTask = reference.putFile(image);
    await uploadTask.then((res) {
      print("working 2");
      res.ref.getDownloadURL().then((fileURL) {
        uploadToDbs(fileURL, name);
      });
    });
  }

  uploadToDbs(String imageUrl, String name) {
    print("working 3");
    if (imageUrl.isNotEmpty) {
      Map<String, dynamic> userInfo = {
        "uid": userId,
        "name": name,
        "imageUrl": imageUrl,
        "date": DateTime.now().microsecondsSinceEpoch,
      };
      print(userId);
      if(userId!=null){
        database.uploadUserInfo(context, userId!, userInfo);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const Homepage()),
                (route) => false);
      }

    } else {
      helperUI.showSnackBar(context, "Something went wrong !");
    }
  }
}
