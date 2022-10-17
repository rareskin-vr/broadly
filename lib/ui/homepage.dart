import 'package:broadly/helper/log.dart';
import 'package:broadly/helper/userdata.dart';
import 'package:broadly/ui/profile.dart';
import 'package:broadly/ui/tweet.dart';
import 'package:flutter/material.dart';
import 'package:broadly/helper/helpeui.dart';

class Homepage extends StatefulWidget {
  final UserData userData;
  const Homepage({Key? key, required this.userData}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HelperUI helperUI = HelperUI();
  @override
  Widget build(BuildContext context) {
    Log log = Log(context);
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const CircleAvatar(
                    backgroundColor: Colors.indigo,
                    minRadius: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Text(
                      widget.userData.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Log out"),
              onTap: () {
                log.logOut();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TweetNow()));
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.message_outlined),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.indigo,
                  minRadius: 20,
                )),
          ),
        ],
        title: const Text("Broadly"),
        backgroundColor: Colors.black,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
              child: Text(
                "All Tweets:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return helperUI.tweetTile(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
