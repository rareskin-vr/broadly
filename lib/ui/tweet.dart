import 'package:broadly/database/database.dart';
import 'package:broadly/helper/userdata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TweetNow extends StatefulWidget {
  final UserData userData;
  const TweetNow({Key? key, required this.userData}) : super(key: key);

  @override
  State<TweetNow> createState() => _TweetNowState();
}

class _TweetNowState extends State<TweetNow> {
  String? _chosenValue = "Public";
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  Database database=Database();
  final formKey = GlobalKey<FormState>();
  TextEditingController tweet = TextEditingController();
  validatingNow() async{
    if (formKey.currentState!.validate()&&tweet.text.isNotEmpty) {
      {
        Map<String, dynamic> userTweet = {
          "uid": userId,
          "name": widget.userData.name,
          "imageUrl": widget.userData.imgPath,
          "tweet":tweet.text,
          "privacy":_chosenValue!.toLowerCase(),
          "date": DateTime.now().microsecondsSinceEpoch,
        };
        await database.tweetNow(userTweet);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(),actions: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: OutlinedButton(
            onPressed: () {
              validatingNow();
            },
            child: const Text("Tweet")),
      ),],
        backgroundColor: Colors.black87,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child:   CachedNetworkImage(
                  imageUrl: widget.userData.imgPath,
                  imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider,
                    minRadius: 30,
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                      minRadius: 30,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        borderRadius: BorderRadius.circular(30),
                        value: _chosenValue,
                        //elevation: 5,
                        items: <String>[
                          'Public',
                          'Private',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenValue = value ?? "Public";
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 12, 0),
            child: Form(key: formKey,
              child: TextFormField(validator: (val) {
                return val!.isEmpty ? "What's happening?" : null;
              },
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                style: const TextStyle(fontSize: 18),
                maxLines: 15,
                cursorHeight: 25,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What's happening?",
                    hintStyle: TextStyle(fontSize: 20)),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
