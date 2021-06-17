import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/all_imports.dart';

String convertTime(String time) {
  time = time.substring(0, time.length - 5);
  time = time.replaceFirst(r'T', " | ");
  return time;
}

String removeLinks(String text) {
  List<String> listtext = text.split(" ");
  text = "";
  for (int i = 0; i < listtext.length; i++) {
    if (listtext[i].indexOf("https") == -1) {
      text += " " + listtext[i];
    }
  }

  return text;
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
    padding: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: d, borderRadius: BorderRadius.circular(5)),
      child: Container(
        margin: EdgeInsets.all(9),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade700)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      360,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: displayPicture.toString(),
                      placeholder: (context, url) => Container(
                        color: d7,
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    name.toString(),
                    style: GoogleFonts.getFont("Sen", color: w, fontSize: 18),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    username.toString(),
                    style: GoogleFonts.getFont("Sen",
                        color: Colors.grey.shade500, fontSize: 13),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ])

                //
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 10),
              child: Text(
                removeLinks(text.toString()),
                textAlign: TextAlign.left,
                style: GoogleFonts.getFont("Sen", color: w, fontSize: 15),
              ),
            ),
            imageThere == true
                ? Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < imgUrls.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.215,
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: imgUrls[i].toString(),
                                    placeholder: (context, url) => Container(
                                      color: d7,
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
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  convertTime(createdAt),
                  style: GoogleFonts.getFont("Sen",
                      color: Colors.grey.shade500, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
