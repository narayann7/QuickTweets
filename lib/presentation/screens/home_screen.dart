import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/logic/cubits/getData/getdata_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';
import 'package:quicktweets/presentation/screens/twitter_timeline_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  String usernamex = "";
  @override
  Widget build(BuildContext context) {
    showAlertDeleteDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        contentTextStyle: TextStyle(fontSize: 18, color: Colors.white),
        //   backgroundColor: Colors.transparent,
        content: Container(
          width: 280.0,
          height: 130,
          child: CircularProgressIndicator(),
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

    return WillPopScope(
      onWillPop: () async {
        return await false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: d,
            actions: [
              GestureDetector(
                onTap: () {
                  teleport(context, collection);
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(
                    Icons.favorite,
                    color: p9,
                  ),
                ),
              )
            ],
            leading: GestureDetector(
                onTap: () async {
                  var user = FirebaseAuth.instance;
                  showAlertDeleteDialog(context);
                  //   Future.delayed(Duration(seconds: 10));

                  await user.signOut().then((value) {
                    Navigator.pushNamed(context, login);
                  });
                },
                child: Icon(
                  Icons.logout,
                  color: p9,
                )),
          ),
          body: BlocConsumer<GetdataCubit, GetdataState>(
              listener: (context, state) {
                if (state.getdataStatus == GetdataStatus.success) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return TwitterTimeLineScreen(
                      twitterPosts: state.twitterPosts,
                      twitterUser: state.twitterUser,
                    );
                  }));
                  setState(() {
                    usernamex = "";
                  });
                }

                if (state.getdataStatus == GetdataStatus.error) {
                  setState(() {
                    usernamex = "error";
                  });
                }
              },
              builder: (context, state) =>
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/bg.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: state.getdataStatus ==
                                            GetdataStatus.error
                                        ? Colors.red
                                        : state.getdataStatus ==
                                                GetdataStatus.loading
                                            ? p9
                                            : Colors.transparent,
                                    blurRadius: 15,
                                    // offset: Offset(5, 5),
                                    spreadRadius: 6)
                              ],
                              color: d)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: d),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: d3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: "enter username",
                                        hintStyle: TextStyle(color: w),
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      setState(() {
                                        username = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  context
                                      .read<GetdataCubit>()
                                      .enterUsername(username);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: d3),
                                  child: state.getdataStatus ==
                                          GetdataStatus.loading
                                      ? Image.asset(
                                          "images/lo1.gif",
                                          height: 125.0,
                                          width: 125.0,
                                        )
                                      : Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: p9,
                                        ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                usernamex,
                                style: TextStyle(color: w),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]))),

      //  /-----------------------------
    );
  }
}
