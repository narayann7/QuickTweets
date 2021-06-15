import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/data/fetch_from_api.dart';
import 'package:quicktweets/data/twitter_post_to_display.dart';
import 'package:quicktweets/data/twitter_posts.dart';
import 'package:quicktweets/data/twitter_user.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';
import 'package:quicktweets/presentation/extraWidgets/more_than_onces.dart';

class TwitterTimeLineScreen extends StatefulWidget {
  TwitterUser? twitterUser;
  TwitterPosts? twitterPosts;
  TwitterTimeLineScreen({
    Key? key,
    required this.twitterUser,
    required this.twitterPosts,
  }) : super(key: key);

  @override
  _TwitterTimeLineScreenState createState() => _TwitterTimeLineScreenState();
}

class _TwitterTimeLineScreenState extends State<TwitterTimeLineScreen> {
  ScrollController scrollController = new ScrollController();
  var collections = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  List<Tweets> addingBothClasses(List<Tweets> tweets) {
    for (int i = 0; i < tweets.length; i++) {
      if (tweets[i].id == "") {
        tweets.removeAt(i);
      }
      tweets[i].displayPicture = widget.twitterUser!.data!.profileImageUrl;
      tweets[i].uid = widget.twitterUser!.data!.id;
      tweets[i].name = widget.twitterUser!.data!.name;
      tweets[i].username = widget.twitterUser!.data!.username;
    }
    return tweets;
  }

  List<Tweets> tweets = [];
  bool pos = false;
  String? nextPostId;
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        FetchFromApi fetchFromApi = FetchFromApi();

        bool x = await fetchFromApi.getUserTweets(
            next: nextPostId,
            nextRequired: true,
            uid: widget.twitterUser!.data!.id);

        List<Tweets> t = addingBothClasses(fetchFromApi.twitterPosts!.tweets);

        setState(() {
          tweets += t;
          pos = true;
          nextPostId = fetchFromApi.twitterPosts!.meta!.oldestId;
        });
      }
    });
    if (pos == false) {
      tweets = addingBothClasses(widget.twitterPosts!.tweets);
      nextPostId = widget.twitterPosts!.meta!.oldestId;
    }
  }

  @override
  Widget build(BuildContext context) {
    showAlertDeleteDialog(BuildContext context, Tweets t) {
      AlertDialog alert = AlertDialog(
        contentTextStyle: TextStyle(fontSize: 18, color: Colors.white),
        //   backgroundColor: Colors.transparent,
        content: Container(
          width: 280.0,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("this note will be deleted !"),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        collections
                            .collection("userdata")
                            .doc(user!.uid)
                            .collection("tweetData")
                            .add({
                          "createdAt": t.createdAt,
                          "id": t.id,
                          "text": t.text,
                          "imageThere": t.imageThere,
                          "imgUrls": [
                            for (int i = 0; i < t.imgUrls!.length; i++)
                              t.imgUrls![i]
                          ],
                          "username": t.username,
                          "name": t.name,
                          "uid": t.uid,
                          "displayPicture": t.displayPicture
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "confirm",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                  SizedBox(width: 32.1),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "no",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ],
              )
            ],
          ),
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black12,
            borderRadius: new BorderRadius.all(new Radius.circular(12.4)),
          ),
        ),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text("yo"),
        actions: [
          GestureDetector(
            onTap: () {
              teleport(context, collection);
            },
            child: Icon(Icons.favorite),
          )
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: scrollController,
        itemCount: tweets.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: () {
              print("hello bitxh${tweets[i].createdAt} ");
              showAlertDeleteDialog(context, tweets[i]);
            },
            child: displayTweets(
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
          );
        },
      ),
    );
  }
}
