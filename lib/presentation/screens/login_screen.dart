import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/logic/cubits/login_cubit/login_cubit.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';

class Loginscreen extends StatelessWidget {
//   const Loginscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        if (state.loginstatus == Loginstatus.success) teleport(context, splash);
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) =>
                        context.read<LoginCubit>().fillEmail(email: value),
                    decoration: InputDecoration(hintText: 'email'),
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (pass) =>
                        context.read<LoginCubit>().fillPass(pass: pass),
                    decoration: InputDecoration(hintText: 'pass'),
                    style: TextStyle(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("login");
                    context.read<LoginCubit>().login();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.amber[100]),
                    child: Text(
                      "login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("signup");
                    Navigator.of(context).pushNamed(signup);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
