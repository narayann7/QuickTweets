import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/data/auth.dart';
import 'package:quicktweets/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:quicktweets/logic/cubits/getData/getdata_cubit.dart';
import 'package:quicktweets/logic/cubits/login_cubit/login_cubit.dart';
import 'package:quicktweets/logic/cubits/signup_cubit/cubit/signup_cubit.dart';
import 'package:quicktweets/presentation/screens/home_screen.dart';
import 'package:quicktweets/presentation/screens/login_screen.dart';
import 'package:quicktweets/presentation/screens/signup_screen.dart';
import 'package:quicktweets/presentation/screens/splash_screen.dart';
import 'package:quicktweets/presentation/screens/tweet_collection.dart';
import 'package:quicktweets/presentation/screens/twitter_timeline_screen.dart';
import 'all_constants.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class Customroutes {
  static Route generateroute(RouteSettings settings) {
    print("${settings.name}");

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/splash'),
            builder: (_) => BlocProvider<AuthBloc>(
                  create: (newcontext) => AuthBloc(firebaseAuth: firebaseAuth),
                  child: Splashscreen(),
                ));
      // case twitterTimeLine:
      //   return MaterialPageRoute(
      //       settings: const RouteSettings(name: '\twitterTimeLine'),
      //       builder: (context) => TwitterTimeLineScreen());
      case home:
        return MaterialPageRoute(
            settings: const RouteSettings(name: '\home'),
            builder: (context) => BlocProvider<GetdataCubit>(
                create: (context) => GetdataCubit(), child: HomeScreen()));
      case collection:
        return MaterialPageRoute(
            settings: const RouteSettings(name: '\collection'),
            builder: (context) => TweetCollection());

      case login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/login'),
          builder: (_) => BlocProvider<LoginCubit>(
              create: (newcontext) =>
                  LoginCubit(authClass: newcontext.read<AuthClass>()),
              child: Loginscreen()),
        );
      case signup:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/signup'),
          builder: (_) => BlocProvider<SignupCubit>(
              create: (newcontext) =>
                  SignupCubit(authClass: newcontext.read<AuthClass>()),
              child: Signupscreen()),
        );

      default:
        return errorroute();
    }
  }

  static errorroute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              body: Container(
                alignment: Alignment.center,
                //   decoration: BoxDecoration(color: Colors.amber[100]),
                child: Text(
                  "error , something went wrong",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ));
  }
}
