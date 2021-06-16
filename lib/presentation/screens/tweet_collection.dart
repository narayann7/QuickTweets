import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/data/twitter_post_to_display.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';
import 'package:quicktweets/presentation/extraWidgets/more_than_onces.dart';

class TweetCollection extends StatefulWidget {
  TweetCollection({Key? key}) : super(key: key);

  @override
  _TweetCollectionState createState() => _TweetCollectionState();
}

class _TweetCollectionState extends State<TweetCollection> {
  var collections = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("collection"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(
            "images/lo1.gif",
            height: 125.0,
            width: 125.0,
          ),
        ]));
  }
}
