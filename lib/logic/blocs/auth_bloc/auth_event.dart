part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class UserWillchange extends AuthEvent {}

class LogoutReq extends AuthEvent {}
