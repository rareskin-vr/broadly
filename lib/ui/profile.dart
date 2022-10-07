import 'package:broadly/ui/tweet.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return tweetTile();
                        }),
                  ),
                )
              ]),
        ));
  }

  Padding tweetTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width,
        //color: Colors.black87,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Colors.indigo,
                minRadius: 25,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Shivam Kumar Singh",
                        //style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          "12/10/22",
                          //style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Let’s try this then: the will of the people who live in the Donbas & Crimea should decide whether they’re part of Russia or Ukraine",
                            maxLines: 5,
                            //style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
