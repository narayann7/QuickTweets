import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/logic/cubits/signup_cubit/cubit/signup_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            teleport(context, splash);
        },
        builder: (context, state) => Scaffold(
              body: Center(
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) =>
                            context.read<SignupCubit>().fillUsername(value),
                        decoration: InputDecoration(hintText: 'username'),
                        style: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) =>
                            context.read<SignupCubit>().fillEmail(value),
                        decoration: InputDecoration(hintText: 'email'),
                        style: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) =>
                            context.read<SignupCubit>().fillPassword(value),
                        decoration: InputDecoration(hintText: 'pass'),
                        style: TextStyle(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("signup");
                        context.read<SignupCubit>().signup();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(color: Colors.amber[100]),
                        child: Text(
                          "signup",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ));
  }
}
