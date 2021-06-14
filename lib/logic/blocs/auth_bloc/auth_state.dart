part of 'auth_bloc.dart';

class AuthState {
  Auth_enum auth_enum;
  AuthState({
    this.auth_enum = Auth_enum.login,
  });

  factory AuthState.login() {
    return AuthState(auth_enum: Auth_enum.login);
  }
  factory AuthState.home() {
    return AuthState(auth_enum: Auth_enum.home);
  }
  factory AuthState.eror() {
    return AuthState(auth_enum: Auth_enum.error);
  }
}
