import 'package:flutter/material.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("home"),
            actions: [Icon(Icons.favorite)],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(),
                ),
                GestureDetector(
                  onTap: () {
                    teleport(context, twitterTimeLine);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: Colors.amber[100]),
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
