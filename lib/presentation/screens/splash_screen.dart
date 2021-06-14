import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktweets/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
import 'package:quicktweets/logic/utility/morethanonces.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.auth_enum == Auth_enum.login) {
          teleport(context, login);
        }
        if (state.auth_enum == Auth_enum.home) teleport(context, home);
      },
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
