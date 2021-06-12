import 'package:flutter/material.dart';
import 'package:quicktweets/test.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//   final twitterApi = TwitterApi(
//       client: TwitterClient(
//     consumerKey: "WAX7Ydkk10cpFmbEP5OqdmAeM",
//     consumerSecret: "hDg5igGxLkIHLkSZIzgc6AtdArn7gG5B6XxID3wAzGrrYqXtno",
//     secret: "CTt4dZczpRGC0PGW8azxBqaGNSLK9LNAXi7XF1WALsyJZ",
//     token: "1188650884965658625-NaogN43YFfplDv0w9g2dzn1dthWKaY",
//   ));
//   getdata() async {
//     var url =
//         "https://api.twitter.com/2/users/1188650884965658625/tweets?max_results=30&expansions=attachments.poll_ids,attachments.media_keys,author_id,entities.mentions.username,geo.place_id,in_reply_to_user_id,referenced_tweets.id,referenced_tweets.id.author_id&tweet.fields=author_id,created_at,public_metrics&user.fields=profile_image_url,created_at&media.fields=url,duration_ms,type";
//     var walljson = await http.get(Uri.parse(url), headers: {
//       "Authorization":
//           "Bearer AAAAAAAAAAAAAAAAAAAAADgwQgEAAAAAjCP3dQIuTcdw2bKoCagfjvMik00%3DAFLOeWAX7JBstGrFUfnvcy0oqNK8ke1kz6ZtWKhSZXtlLGT3Sg"
//     });

//     print(walljson.body.toString());
//
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //  getdata();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
