import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicktweets/logic/cubits/login_cubit/login_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Loginscreen extends StatelessWidget {
//   const Loginscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String error = "";
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showAlertDeleteDialogClose(BuildContext context) {
      AlertDialog alert = AlertDialog(
        contentTextStyle: TextStyle(fontSize: 18, color: Colors.white),
        backgroundColor: d,
        content: Container(
          width: 280.0,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" Want to close ? "),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: d7),
                      onPressed: () {
                        SystemNavigator.pop();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "confirm",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                  SizedBox(width: 32.1),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: d7),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "no",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ],
              )
            ],
          ),
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

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loginstatus == Loginstatus.submmiting) {
          showDialog(
              context: context,
              builder: (_) => Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.5)),
                    child: CircularProgressIndicator(),
                  ));
        }

        if (state.loginstatus == Loginstatus.success)
          Navigator.pushNamed(context, splash);
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async {
            showAlertDeleteDialogClose(context);
            return await false;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/sc1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: GoogleFonts.getFont('Sen',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: Colors.white70,
                                  fontSize: 70),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.24,
                            ),
                            Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: MultiValidator([
                                        EmailValidator(
                                            errorText: "not a valid email"),
                                        RequiredValidator(errorText: "required")
                                      ]),
                                      cursorColor: d3,
                                      onChanged: (value) => context
                                          .read<LoginCubit>()
                                          .fillEmail(email: value),
                                      decoration: InputDecoration(
                                        hintText: 'email',
                                      ),
                                      style: TextStyle(),
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      validator: (v) {
                                        if (v!.isEmpty || v.length < 6) {
                                          return "atleast greater than 6";
                                        }
                                      },
                                      onChanged: (pass) => context
                                          .read<LoginCubit>()
                                          .fillPass(pass: pass),
                                      decoration:
                                          InputDecoration(hintText: 'pass'),
                                      style: TextStyle(),
                                    ),
                                  ],
                                )),
                            if (state.loginstatus == Loginstatus.error)
                              Text("error"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(signup);
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: GoogleFonts.getFont('Quicksand',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                        color: d2,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Stack(alignment: Alignment.center, children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: p9),
                                  ),
                                  Positioned(
                                    right: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<LoginCubit>().login();
                                      },
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.getFont('Quicksand',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                            color: d2,
                                            fontSize: 45),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
