import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quicktweets/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool firstTime = true;

    List<Color> c = [p8, p1, m];
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.auth_enum == Auth_enum.login) {
        firstTime = false;
        teleportReplace(context, login);
      }
      if (state.auth_enum == Auth_enum.home) {
        firstTime = false;
        teleportReplace(context, home);
      }
    }, builder: (context, state) {
      return firstTime == false
          ? Scaffold(
              body: Center(
              child: CircularProgressIndicator(),
            ))
          : Scaffold(
              body: LiquidSwipe(
                pages: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //   width: 1000,
                    color: c[0],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          child: Image(image: AssetImage("images/3.png")),
                          decoration: BoxDecoration(),
                        ),
                        Text(
                          "Welcome",
                          style: GoogleFonts.getFont('Comfortaa',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: Colors.white70,
                              fontSize: 50),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "it's an app madewith flutter which uses twitters api",
                            style: GoogleFonts.getFont('Quicksand',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                color: Colors.white70,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(UserWillchange());
                          },
                          child: Container(
                            child: Text(
                              "skip",
                              style: GoogleFonts.getFont('Quicksand',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.white70,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: c[1],
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          child: Image(image: AssetImage("images/4.png")),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "How to uses?",
                          style: GoogleFonts.getFont('Comfortaa',
                              fontWeight: FontWeight.w700,
                              color: b1,
                              fontSize: 35),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            //   width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "- Login (if dont have account not signUp)\n- Search any twitter user by its username.\n- It will showUp all tweets of the \nrespective user.\n- Form which you can save your favourite ones by holding them for 1 sec.\n( it will automatically sink to cloud )",
                              style: GoogleFonts.getFont('Maven Pro',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: d2,
                                  fontSize: 19),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(UserWillchange());
                          },
                          child: Container(
                            child: Text(
                              "skip",
                              style: GoogleFonts.getFont('Quicksand',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: d3,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: c[2],
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          child: Image(image: AssetImage("images/7.png")),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Lets Go!",
                          style: GoogleFonts.getFont('Comfortaa',
                              fontWeight: FontWeight.w800,
                              color: Colors.white70,
                              fontSize: 50),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(UserWillchange());
                          },
                          child: Container(
                            child: Text(
                              "Next",
                              style: GoogleFonts.getFont('Quicksand',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                  fontSize: 40),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                fullTransitionValue: 700,
                enableLoop: false,
                ignoreUserGestureWhileAnimating: true,
                //  enableSideReveal: true,
                waveType: WaveType.liquidReveal,
              ),
            );
    });
  }
}
