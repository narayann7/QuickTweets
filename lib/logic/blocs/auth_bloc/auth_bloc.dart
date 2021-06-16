import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  auth.FirebaseAuth _firebaseAuth;
  AuthBloc({required auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(AuthState.initial()) {
    if (_firebaseAuth.currentUser != null) add(UserWillchange());
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SkipOrNext) yield AuthState.login();
    if (event is UserWillchange) {
      if (_firebaseAuth.currentUser != null)
        yield AuthState.home();
      else
        yield AuthState.login();
    }
    if (event is LogoutReq) {
      await _firebaseAuth.signOut();
      yield AuthState.login();
    }
  }
}
