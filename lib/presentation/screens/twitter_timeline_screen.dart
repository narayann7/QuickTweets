import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/data/fetch_from_api.dart';
import 'package:quicktweets/data/twitter_post_to_display.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';

class TwitterTimeLineScreen extends StatefulWidget {
  TwitterTimeLineScreen({Key? key}) : super(key: key);

  @override
  _TwitterTimeLineScreenState createState() => _TwitterTimeLineScreenState();
}

class _TwitterTimeLineScreenState extends State<TwitterTimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    FetchFromApi fetchFromApi = FetchFromApi();
    //  TwitterPosts? twitterPosts;
    var collections = FirebaseFirestore.instance;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    var user = _firebaseAuth.currentUser;

    List<Tweets>? t;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // fetchFromApi.getUserData();

          print(user!.email);
          //  collections
          //      .collection("userdata")
          //      .doc(user.uid)
          //      .collection("tweetData")
          //      .add({
          //    "createdAt": t![1].createdAt,
          //    "id": t![1].id,
          //    "text": t![1].text,
          //    "imageThere": t![1].imageThere,
          //    "imgUrls": [
          //      for (int i = 0; i < t![1].imgUrls!.length; i++) t![1].imgUrls![i]
          //    ],
          //    "username": t![1].username,
          //    "name": t![1].name,
          //    "uid": t![1].uid,
          //    "displayPicture": t![1].displayPicture
          //  });
        },
      ),
      appBar: AppBar(
        title: Text("yo"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
