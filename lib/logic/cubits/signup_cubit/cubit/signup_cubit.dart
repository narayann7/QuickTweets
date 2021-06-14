import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quicktweets/data/auth.dart';
import 'package:quicktweets/data/errors.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthClass authClass;

  SignupCubit({
    required this.authClass,
  }) : super(SignupState.initial());

  void fillUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void fillEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void fillPassword(String password) {
    emit(state.copyWith(password: password));
  }

  void signup() async {
    emit(state.copyWith(signupstatus: Signupstatus.submmiting));
    try {
      await authClass.signUpWithEmailAndPass(
          username: state.username,
          email: state.email,
          password: state.password);

      emit(state.copyWith(signupstatus: Signupstatus.success));
    } on Failure catch (e) {
      print(e);
      emit(state.copyWith(signupstatus: Signupstatus.error));
    }
  }
}
