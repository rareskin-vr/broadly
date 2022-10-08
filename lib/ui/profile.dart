import 'package:broadly/ui/tweet.dart';
import 'package:flutter/material.dart';
import 'package:broadly/helper/helpeui.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  HelperUI helperUI=HelperUI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const TweetNow()));
          },
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.message_outlined),
        ),
        appBar: AppBar(
          title: const Text("Broadly"),
          backgroundColor: Colors.black,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: Colors.black87,
                    ),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.indigo,
                            minRadius: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "Shivam Kumar Singh",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 30),
                          child: OutlinedButton(
                              onPressed: () {},
                              child: const Text("Edit Profile")),
                        ))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(
                    "Tweets:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SizedBox(
                    child: ListView.builder(shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 50,
                        itemBuilder: (BuildContext context, int index) {
                          return helperUI.tweetTile(context);
                        }),
                  ),
                )
              ]),
        ));
  }
}
