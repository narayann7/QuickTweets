import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
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
    showAlertDeleteDialog(BuildContext context, DocumentSnapshot ds) {
      AlertDialog alert = AlertDialog(
        contentTextStyle: TextStyle(fontSize: 18, color: Colors.white),
        backgroundColor: d,
        content: Container(
          width: 280.0,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" Want to delete is ? "),
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
                            .doc(ds.id)
                            .delete();
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
                image: AssetImage("images/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: StreamBuilder<QuerySnapshot>(
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
                      return GestureDetector(
                        onTap: () {
                          showAlertDeleteDialog(context, ds);
                        },
                        child: displayTweets(
                          context,
                          ds["createdAt"],
                          ds["id"],
                          ds["text"],
                          ds["imageThere"],
                          ds["imgUrls"],
                          ds["username"],
                          ds["name"],
                          ds["uid"],
                          ds["displayPicture"],
                        ),
                      );
                    },
                  );
                }
                return Text("no data");
              },
            ),
          ),
        ]));
  }
}
