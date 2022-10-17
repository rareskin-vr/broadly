import 'package:broadly/helper/userdata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HelperUI {
  Padding tweetTile(BuildContext context,UserData userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width,
        //color: Colors.black87,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:   CachedNetworkImage(
                imageUrl: userData.imgPath,
                imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider,
                  minRadius: 25,
                ),
                placeholder: (context, url) => const CircleAvatar(
                    minRadius: 25,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        userData.name,
                        //style: TextStyle(color: Colors.white),
                      ),
                      const Padding(
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

  showLoaderDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(text)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showSnackBar(BuildContext context, String text) {
    var snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
