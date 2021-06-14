import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/data/fetch_from_api.dart';
import 'package:quicktweets/logic/cubits/getData/getdata_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
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
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //   teleport(context, twitterTimeLine);
                      context.read<GetdataCubit>().enterUsername(username);
                      // print("nn");
                      // FetchFromApi fetchFromApi = FetchFromApi();
                      // fetchFromApi.getUserData(username);
                    },
                    child: BlocConsumer<GetdataCubit, GetdataState>(
                      listener: (context, state) {
                        if (state.getdataStatus == GetdataStatus.success) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return TwitterTimeLineScreen();
                          }));

                          print(state.twitterUser!.data!.name);
                          print("yahooo");
                        }

                        if (state.getdataStatus == GetdataStatus.error) {
                          setState(() {
                            usernamex = "error";
                          });
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color: Colors.amber[100]),
                          child: state.getdataStatus == GetdataStatus.loading
                              ? CircularProgressIndicator()
                              : Icon(Icons.arrow_forward_ios_rounded),
                        );
                      },
                    ),
                  ),
                  Text(usernamex)
                ],
              ),
            )));
  }
}
