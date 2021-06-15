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
        body: StreamBuilder<QuerySnapshot>(
          stream: collections
              .collection("userdata")
              .doc(user!.uid)
              .collection("tweetData")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  print(snapshot.data!.docs.length);

                  // Tweets? t;
                  // t!.createdAt = ds["createdAt"];
                  // t.displayPicture = ds["displayPicture"];
                  // t.id = ds["id"];
                  // t.imageThere = ds["imageThere"];
                  // t.text = ds["text"];
                  // t.name = ds["name"];
                  // t.uid = ds["uid"];
                  // t.username = ds["username"];
                  // t.imgUrls = ds["imgUrls"];

                  return GestureDetector(onTap: () {}, child: Text("helo")

                      //   displayTweets(
                      //     context: context,
                      //     createdAt: t.createdAt,
                      //     displayPicture: t.displayPicture,
                      //     name:t.name ,
                      //     imageThere: t.imageThere,
                      //     imgUrls: t.imgUrls,
                      //     postId: t.id,
                      //     text: t.text,
                      //     uid:t.uid,
                      //     username:t.username,
                      //   ),
                      );
                },
              );
            }
            return Text("no data");
          },
        ));
  }
}
