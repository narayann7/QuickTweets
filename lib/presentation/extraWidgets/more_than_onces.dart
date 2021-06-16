import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';

Widget dis(String x) {
  return Text("o");
}

Widget displayTweets(
    BuildContext context,
    String createdAt,
    String postId,
    String text,
    bool imageThere,
    List<dynamic> imgUrls,
    String username,
    String name,
    String uid,
    String displayPicture) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.amber[100]),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: displayPicture.toString(),
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(name.toString()),
                SizedBox(
                  width: 20,
                ),
                Text(username.toString()),
                SizedBox(
                  width: 20,
                ),

                //
              ],
            ),
            Text(text.toString()),
            imageThere == true
                ? Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < imgUrls.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    imageUrl: imgUrls[i].toString(),
                                    placeholder: (context, url) => Container(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator()
                                        //   child: CircularProgressIndicator(),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Text(createdAt),
          ],
        ),
      ),
    ),
  );
}
