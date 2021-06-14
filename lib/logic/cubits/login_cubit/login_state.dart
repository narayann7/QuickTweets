part of 'login_cubit.dart';

class LoginState extends Equatable {
  String email;
  String password;
  Loginstatus loginstatus;
  Failure failure;
  LoginState({
    required this.email,
    required this.password,
    required this.loginstatus,
    required this.failure,
  });
  factory LoginState.initial() {
    return LoginState(
        email: "",
        password: "",
        loginstatus: Loginstatus.initial,
        failure: Failure());
  }

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [email, password, loginstatus, failure];

  LoginState copyWith({
    String? email,
    String? password,
    Loginstatus? loginstatus,
    Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginstatus: loginstatus ?? this.loginstatus,
      failure: failure ?? this.failure,
    );
  }
}
