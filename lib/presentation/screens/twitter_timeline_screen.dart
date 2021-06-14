import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/data/fetch_from_api.dart';
import 'package:quicktweets/data/twitter_post_to_display.dart';
import 'package:quicktweets/data/twitter_posts.dart';
import 'package:quicktweets/data/twitter_user.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';
import 'package:quicktweets/presentation/extraWidgets/more_than_onces.dart';

class TwitterTimeLineScreen extends StatefulWidget {
  TwitterUser? twitterUser;
  TwitterPosts? twitterPosts;
  TwitterTimeLineScreen({
    required this.twitterUser,
    required this.twitterPosts,
  });

  @override
  _TwitterTimeLineScreenState createState() => _TwitterTimeLineScreenState();
}

class _TwitterTimeLineScreenState extends State<TwitterTimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    List<Tweets> addingBothClasses(List<Tweets> tweets) {
      tweets.removeAt(0);
      for (int i = 0; i < tweets.length; i++) {
        tweets[i].displayPicture = widget.twitterUser!.data!.profileImageUrl;
        tweets[i].uid = widget.twitterUser!.data!.id;
        tweets[i].name = widget.twitterUser!.data!.name;
        tweets[i].username = widget.twitterUser!.data!.username;
      }

      return tweets;
    }

    List<Tweets> tweets = addingBothClasses(widget.twitterPosts!.tweets);

    //  FetchFromApi fetchFromApi = FetchFromApi();
    //  //  TwitterPosts? twitterPosts;
    //  var collections = FirebaseFirestore.instance;
    //  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    //  var user = _firebaseAuth.currentUser;

    //  List<Tweets>? t;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
      appBar: AppBar(
        title: Text("yo"),
      ),
      body: SingleChildScrollView(
        //   controller: controller,

        child: Column(
          children: [
            for (int i = 0; i < tweets.length; i++)
              displayTweets(
                context: context,
                createdAt: tweets[i].createdAt,
                displayPicture: tweets[i].displayPicture,
                name: tweets[i].name,
                imageThere: tweets[i].imageThere,
                imgUrls: tweets[i].imgUrls,
                postId: tweets[i].id,
                text: tweets[i].text,
                uid: tweets[i].uid,
                username: tweets[i].username,
              ),
          ],
        ),
      ),
    );
  }
}
