import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';

import 'errors.dart';

class AuthClass {
//   FirebaseFirestore? _firebaseFirestore;
  auth.FirebaseAuth? _firebaseAuth;

  String? mail() {
    return _firebaseAuth!.currentUser!.email;
  }

  AuthClass({required auth.FirebaseAuth? fA}) {
    _firebaseAuth = fA;
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth!.currentUser!;
    return user != null;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth?.signOut();
  }

  @override
  Future<auth.User?> signInWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      throw Failure(code: e.code, message: e.message);
    } on PlatformException catch (e) {
      print(e);
      throw Failure(code: e.code, message: e.message);
    }
  }

  @override
  Future<auth.User?> signUpWithEmailAndPass(
      {required String username,
      required String email,
      required String password}) async {
    final user;
    try {
      final credential = await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.updateProfile(displayName: username);
      user = credential.user;
      //   _firebaseFirestore!.collection(path.users).doc(user.uid).set({
      //     'username': username,
      //     'email': email,
      //     'followers': 0,
      //     'following': 0
      //   });
      return user;
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      throw Failure(code: e.code, message: e.message);
    } on PlatformException catch (e) {
      print(e);
      throw Failure(code: e.code, message: e.message);
    }
  }
}
