part of 'signup_cubit.dart';

class SignupState extends Equatable {
  String email;
  String username;
  String password;
  Signupstatus signupstatus;
  Failure failure;
  SignupState({
    required this.email,
    required this.username,
    required this.password,
    required this.signupstatus,
    required this.failure,
  });

  factory SignupState.initial() {
    return SignupState(
        email: "",
        username: "",
        password: "",
        signupstatus: Signupstatus.initial,
        failure: Failure());
  }

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [email, username, password, signupstatus, failure];

  SignupState copyWith({
    String? email,
    String? username,
    String? password,
    Signupstatus? signupstatus,
    Failure? failure,
  }) {
    return SignupState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      signupstatus: signupstatus ?? this.signupstatus,
      failure: failure ?? this.failure,
    );
  }
}
