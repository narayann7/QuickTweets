import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: d,
        content: Container(
          width: 280.0,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Want to save this?"),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: d7),
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
                      style: ElevatedButton.styleFrom(primary: d7),
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
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: p9,
            ),
          ),
          backgroundColor: d,
          actions: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  teleport(context, collection);
                },
                child: Icon(
                  Icons.favorite,
                  color: p9,
                ),
              ),
            )
          ],
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: d, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey.shade700)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    360,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: widget
                                        .twitterUser!.data!.profileImageUrl
                                        .toString(),
                                    placeholder: (context, url) => Container(
                                      color: d7,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.twitterUser!.data!.name.toString(),
                                      style: GoogleFonts.getFont("Sen",
                                          color: w, fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.twitterUser!.data!.username
                                          .toString(),
                                      style: GoogleFonts.getFont("Sen",
                                          color: Colors.grey.shade500,
                                          fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ]),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 65, bottom: 2),
                            child: Text(
                              removeLinks(widget.twitterUser!.data!.description
                                  .toString()),
                              style: GoogleFonts.getFont("Sen",
                                  color: w, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 65, bottom: 2),
                            child: Text(
                              removeLinks(
                                  "followers :${widget.twitterUser!.data!.publicMetrics!.followersCount.toString()}"),
                              style: GoogleFonts.getFont("Sen",
                                  color: w, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 65, bottom: 2),
                            child: Text(
                              removeLinks(
                                  "following :${widget.twitterUser!.data!.publicMetrics!.followingCount.toString()}"),
                              style: GoogleFonts.getFont("Sen",
                                  color: w, fontSize: 15),
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: scrollController,
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int i) {
                      bool imgthere =
                          tweets[i].imageThere == true ? true : false;

                      List<String> imgurls = [""];

                      if (tweets[i].imageThere == true) {
                        for (int img = 0;
                            img < tweets[i].imgUrls!.length;
                            img++) {
                          imgurls.add(tweets[i].imgUrls![img].toString());
                        }
                        imgurls.removeAt(0);
                      }

                      return GestureDetector(
                        onTap: () {
                          showAlertDeleteDialog(context, tweets[i]);
                        },
                        child: displayTweets(
                          context,
                          tweets[i].createdAt.toString(),
                          tweets[i].id.toString(),
                          tweets[i].text.toString(),
                          imgthere,
                          imgurls,
                          tweets[i].username.toString(),
                          tweets[i].name.toString(),
                          tweets[i].uid.toString(),
                          tweets[i].displayPicture.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
