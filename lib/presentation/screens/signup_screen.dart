import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicktweets/logic/cubits/signup_cubit/cubit/signup_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupstatus == Signupstatus.submmiting) {
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
          if (state.signupstatus == Signupstatus.success)
            Navigator.pushNamed(
              context,
              splash,
            );
        },
        builder: (context, state) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
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
                                "Create\nAccount",
                                style: GoogleFonts.getFont('Sen',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white70,
                                    fontSize: 40),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                              ),
                              Form(
                                  key: formkey,
                                  child: Column(children: [
                                    TextFormField(
                                      validator: (v) {
                                        if (v!.length < 2) {
                                          return "atleast >3";
                                        }
                                      },
                                      cursorColor: d3,
                                      onChanged: (value) => context
                                          .read<SignupCubit>()
                                          .fillUsername(value),
                                      decoration: InputDecoration(
                                        hintText: 'username',
                                      ),
                                      style: TextStyle(),
                                    ),
                                    TextFormField(
                                      cursorColor: d3,
                                      validator: MultiValidator([
                                        EmailValidator(
                                            errorText: "not a valid email"),
                                        RequiredValidator(errorText: "required")
                                      ]),
                                      onChanged: (value) => context
                                          .read<SignupCubit>()
                                          .fillEmail(value),
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
                                          .read<SignupCubit>()
                                          .fillPassword(pass),
                                      decoration:
                                          InputDecoration(hintText: 'pass'),
                                      style: TextStyle(),
                                    ),
                                  ])),
                              if (state.signupstatus == Signupstatus.error)
                                Text("error"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(login);
                                    },
                                    child: Text(
                                      "Login",
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
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
                                      right: 90,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<SignupCubit>().signup();
                                        },
                                        child: Text(
                                          "SignUp",
                                          style: GoogleFonts.getFont(
                                              'Quicksand',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                              color: d2,
                                              fontSize: 35),
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
                  )),
            ));
  }
}
