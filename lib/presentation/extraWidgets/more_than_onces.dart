import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget displayTweets(
    {BuildContext? context,
    String? createdAt,
    String? postId,
    String? text,
    bool? imageThere,
    List<String?>? imgUrls,
    String? username,
    String? name,
    String? uid,
    String? displayPicture}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: Alignment.center,
      height: 100,
      width: MediaQuery.of(context!).size.width,
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
              ],
            ),
            Text(text.toString()),
            Text(createdAt.toString()),
          ],
        ),
      ),
    ),
  );
}
