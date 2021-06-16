import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quicktweets/data/auth.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/custom_routes.dart';

class MyApp extends StatelessWidget {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthClass>(
              create: (_) => AuthClass(fA: _firebaseAuth))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              accentColor: d2, primaryColor: d2, primarySwatch: Colors.grey),
          onGenerateRoute: Customroutes.generateroute,
          initialRoute: splash,
        ));
  }
}
