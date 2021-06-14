import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quicktweets/data/auth.dart';
import 'package:quicktweets/data/errors.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthClass authClass;

  LoginCubit({required this.authClass}) : super(LoginState.initial());

  void fillEmail({required String email}) {
    emit(state.copyWith(email: email, loginstatus: Loginstatus.initial));
  }

  void fillPass({required String pass}) {
    emit(state.copyWith(password: pass, loginstatus: Loginstatus.initial));
  }

  void login() async {
    emit(state.copyWith(loginstatus: Loginstatus.submmiting));
    try {
      await authClass.signInWithEmailAndPass(
          email: state.email, password: state.password);
      emit(state.copyWith(loginstatus: Loginstatus.success));
    } on Failure catch (e) {
      print(e);
      emit(state.copyWith(failure: e, loginstatus: Loginstatus.error));
    }
  }
}
