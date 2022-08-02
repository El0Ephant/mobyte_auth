part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class ErrorEvent extends AuthEvent {
  const ErrorEvent({required this.message});
  final String message;
}

class LogInEvent extends AuthEvent {
  const LogInEvent({required this.login, required this.password});
  final String login;
  final String password;
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({required this.username, required this.email, required this.password});
  final String username;
  final String email;
  final String password;
}

class SendResetEvent extends AuthEvent {
  const SendResetEvent({required this.login});
  final String login;
}

class GoogleLogInEvent extends AuthEvent {
  const GoogleLogInEvent();
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();
}

class DummyEvent extends AuthEvent {
  const DummyEvent();
}